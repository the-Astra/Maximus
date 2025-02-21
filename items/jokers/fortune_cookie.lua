SMODS.Joker {
    key = 'fortune_cookie',
    loc_txt = {
        name = 'Fortune Cookie',
        text = { '{C:green}#3# out of #4#{} chance to receive', 'a random {C:tarot}Tarot{} card when',
            ' playing a hand {C:inactive}(Must have room){}',
            '{C:inactive}Chance reduces by #1# for every played hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    perishable_compat = false,
    eternal_compat = false,
    blueprint_compat = true,
    cost = 4,
    config = {
        extra = {
            prob = 10,
            odds = 10
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.probabilities.normal, center.ability.extra.prob * G.GAME.fridge_mod,
                center.ability.extra.prob * G.GAME.fridge_mod * G.GAME.probabilities.normal,
                center.ability.extra.odds * G.GAME.fridge_mod }
        }
    end,
    calculate = function(self, card, context)
        -- Activate ability before scoring if chance is higher than 0
        if context.before and card.ability.extra.odds > 0 then
            -- Roll chance and decrease by 1
            local chance_roll = pseudorandom(pseudoseed('fco' .. G.GAME.round_resets.ante)) <
                card.ability.extra.prob * G.GAME.fridge_mod * G.GAME.probabilities.normal / card.ability.extra.odds
            card.ability.extra.prob = card.ability.extra.odds - (1 / G.GAME.fridge_mod)

            -- Check if Consumables is full
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                -- Successful roll
                if (chance_roll) then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            card:juice_up(0.3, 0.4)

                            SMODS.add_card({
                                set = 'Tarot',
                                key_append = 'fco'
                            })
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true;
                        end
                    }))
                    return {
                        sound = 'tarot1',
                        card = card,
                        message = 'FORTUNATE!',
                        colour = G.C.SECONDARY_SET.Tarot
                    }

                    -- Failed Roll
                else
                    mxms_scale_pessimistics(card.ability.extra.prob * G.GAME.fridge_mod * G.GAME.probabilities.normal,
                        card.ability.extra.odds)

                    return {
                        sound = 'tarot2',
                        card = card,
                        message = localize('k_nope_ex'),
                        colour = G.C.SET.Tarot
                    }
                end
            else
                return {
                    sound = 'tarot2',
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

        -- "Crumble" card after scoring
        if context.after and not context.blueprint then
            if card.ability.extra.odds <= 0 then
                G.GAME.destroyed_food = card.config.center.key
                -- Code derived from Gros Michel/Cavendish
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
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