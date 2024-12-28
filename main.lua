SMODS.Atlas{
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker { -- Fortune Cookie
    key = 'fortune_cookie',
    loc_txt = {
        name = 'Fortune Cookie',
        text = {
            '{C:attention}#3# out of 10{} chance to receive',
            'a random {C:tarot}Tarot{} card when',
            ' playing a hand {C:inactive}(Must have room){}',
            '{C:inactive} Chance reduces by #1# for every played hand'
        }
    },
    atlas = 'Jokers',
    pos = {x = 0, y = 0},
    rarity = 1,
    perishable_compat = false,
    eternal_compat = false,
    config = { extra = {
            chance = 10
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.chance, center.ability.extra.chance * G.GAME.probabilities.normal}}
    end,
    calculate = function(self,card,context)
        
        if context.before and card.ability.extra.chance > 0 then
            local chance_roll = pseudorandom('fco', 1, 10 * G.GAME.probabilities.normal)
            local chance_odds = 10 - card.ability.extra.chance
            card.ability.extra.chance = card.ability.extra.chance - 1

            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then

                if (chance_roll >= chance_odds) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                            func = function()
                            play_sound('tarot1')
                            card:juice_up(0.3, 0.4)

                            local new_card = create_card('Tarot', G.consumeables, nil,nil,nil,nil,nil,'fco')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                        return true; end
                    }))
                    return {
                        card = card,
                        message = 'FORTUNATE!',
                        colour = G.C.SECONDARY_SET.Tarot
                    }
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function ()
                            play_sound('tarot2')
                        return true; end
                    }))
                    return {
                        card = card,
                        message = 'NOPE!',
                        colour = G.C.SET.Tarot
                    }
                end
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function ()
                        play_sound('tarot2')
                    return true; end
                }))
                return {
                    card = card,
                    message = 'WASTED',
                    colour = G.C.SET.Tarot
                }
            end

            card:juice_up(0.3, 0.4)
            return {
                card = card,
                message = '-1',
                colour = G.C.RED
            }
        end

        if context.end_of_round and context.individual and not context.blueprint then
            if card.ability.extra.chance < 1 then
                --Code taken from Gros Michel/Cavendish
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                            return true; end}))
                        return true 
                    end
                }))
                return {
                    card = card,
                    message = 'Crumbled'
                } 
            end
        end
    end
}

SMODS.Joker { -- Poindexter
    key='poindexter',
    loc_txt = {
        name = "Poindexter",
        text = {
            '{C:mult}x0.25 mult{} for every',
            'scoring {C:red}glass card{} that',
            'remains intact; {C:red}Resets{} on break',
            '{C:inactive}Currently: x#1#{}'
        }
    },
    atlas = 'Jokers',
    rarity = 2,
    pos = {x = 1, y = 0},
    config = { extra = {
        Xmult = 1.0,
        shattered = false
    }},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return {vars = {center.ability.extra.Xmult, center.ability.extra.shattered}}
    end,
    calculate = function(self,card,context)

        if context.joker_main then
            if card.ability.extra.Xmult > 0 then
                return {
                    card = card,
                    Xmult_mod = card.ability.extra.Xmult,
                    message = 'x' .. card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end
        end

        if context.before and not context.blueprint then
            card.ability.extra.shattered = false
        end

        if context.remove_playing_cards and not context.blueprint then

            -- Check for shattered glass
            if context.removed ~= nil then
                for k, val in ipairs(context.removed) do
                    if val.config.center_key == 'm_glass' then 
                        card.ability.extra.Xmult = 1
                        card.ability.extra.shattered = true
                    end
                    if shattered then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                play_sound('tarot2')
                                card:juice_up(0.3, 0.4)
                            return true; end
                        }))
                    end
                end
            end
        end

        if context.after and not context.blueprint then
            if card.ability.extra.shattered then
                return {
                    card = card,
                    message = 'Errrrmmm...',
                    colour = G.C.RED
                }
            else
                -- If no shattered glass, add to mult
                local glass = 0
                for k, val in ipairs(context.scoring_hand) do
                    if val.config.center_key == 'm_glass' then
                        glass = glass + 1
                    end
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card.ability.extra.Xmult = card.ability.extra.Xmult + (glass * 0.25)
                        card:juice_up(0.3, 0.4)
                        play_sound('tarot1')
                        return true; 
                    end
                }))
                return {
                    card = card,
                    message = 'Eureka!',
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker { -- Abyss
    key='abyss',
    loc_txt = {
        name = "Abyss",
        text = {
            'When blind is selected, {C:attention}50/50{}',
            '{C:attention}chance{} of either creating',
            'a random {C:dark_edition}Negative Joker{} or destroying',
            'a currently held non-Negative Joker'
        }
    },
    atlas = 'Jokers',
    rarity = 3,
    pos = {x = 2, y = 0},
    config = {},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return {vars = {}}
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            local flip = pseudorandom('aby', 1, 2)
            sendDebugMessage(flip, "MaximusDebug")

            -- Create a random negative joker
            if flip == 1 then
                local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'aby')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                new_card:set_edition({negative = true}, true)
                card:juice_up(0.3, 0.4)
                play_sound('foil1')
                return {
                    card = card,
                    message = 'Void-touched!',
                    colour = G.C.PURPLE
                }
            
            -- Destroy a random non-negative joker
            elseif flip == 2 then
                -- Code derived Madness
                local deletable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not(G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative) and not G.jokers.cards[i].getting_sliced then 
                        deletable_jokers[#deletable_jokers + 1] = G.jokers.cards[i] 
                    end
                end
                if next(deletable_jokers) == nil then
                    sendDebugMessage('No Deletable Jokers for Abyss', "MaximusDebug")
                    return {
                        card = card,
                        message = 'No target...',
                        colour = G.C.PURPLE
                    }
                else 
                    local chosen_joker = #deletable_jokers > 0 and pseudorandom_element(deletable_jokers, pseudoseed('abyss')) or nil

                    if chosen_joker and not (context.blueprint_card or card).getting_sliced then
                        chosen_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                chosen_joker:start_dissolve({G.C.PURPLE}, nil, 1.6)
                                return true; 
                            end 
                        }))
                        return {
                            card = card,
                            message = 'Consumed',
                            colour = G.C.PURPLE
                        }
                    end
                end
            end
        end
    end
}