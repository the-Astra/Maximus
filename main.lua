-- Load config and save state
Maximus_config = SMODS.current_mod.config

-- Joker Sprite Atlases
SMODS.Atlas {
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = '4D',
    path = "4d_joker.png",
    px = 71,
    py = 95
}

-- Set new variables to init with game
local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.current_round.impractical_hand = 'High Card'
    return ret
end

-- Sounds
SMODS.Sound({
    key = 'perfect',
    path = 'perfect.ogg'
})

SMODS.Sound({
    key = 'eggsplosion',
    path = 'eggsplosion.ogg'
})

-- Misc Variables
local food_jokers = {{
    key = 'j_gros_Michel',
    name = 'Gros Michel'
}, {
    key = 'j_egg',
    name = 'Egg'
}, {
    key = 'j_ice_cream',
    name = 'Ice Cream'
}, {
    key = 'j_cavendish',
    name = 'Cavendish'
}, {
    key = 'j_turtle_bean',
    name = 'Turtle Bean'
}, {
    key = 'diet_cola',
    name = 'Diet Cola'
}, {
    key = 'j_popcorn',
    name = 'Popcorn'
}, {
    key = 'j_ramen',
    name = 'Ramen'
}, {
    key = 'j_seltzer',
    name = 'Seltzer'
}, {
    key = 'j_mxms_fortune_cookie',
    name = 'Fortune Cookie'
}, {
    key = 'j_mxms_leftovers',
    name = 'Leftovers'
}}

-- Variables that change every round
function SMODS.current_mod.reset_game_globals(run_start)

    -- Impractical Joker
    G.GAME.current_round.impractical_hand = G.GAME.current_round.impractical_hand
    local valid_hands = {}

    for k, v in pairs(G.GAME.hands) do
        if v.visible then
            valid_hands[#valid_hands + 1] = k
        end
    end

    local new_hand = G.GAME.current_round.impractical_hand
    while new_hand == G.GAME.current_round.impractical_hand do
        new_hand = pseudorandom_element(valid_hands, pseudoseed('impractical' .. G.GAME.round_resets.ante))
    end
    G.GAME.current_round.impractical_hand = new_hand

end

-- Misc functions

-- 4D Patches (Derived from Jimball animation code)
local upd = Game.update

mxms_4d_dt_anim = 0
mxms_4d_dt_mod = 0

function Game:update(dt)

    upd(self, dt)

    mxms_4d_dt_anim = mxms_4d_dt_anim + dt
    mxms_4d_dt_mod = mxms_4d_dt_mod + dt

    if G.P_CENTERS and G.P_CENTERS.j_mxms_4d and mxms_4d_dt_anim > 0.05 then

        mxms_4d_dt_anim = 0

        local obj = G.P_CENTERS.j_mxms_4d

        if obj.pos.x == 0 and obj.pos.y == 7 then
            obj.pos.x = 0
            obj.pos.y = 0

        elseif obj.pos.x < 9 then
            obj.pos.x = obj.pos.x + 1

        elseif obj.pos.y < 7 then
            obj.pos.x = 0
            obj.pos.y = obj.pos.y + 1

        end

        

    end
    if next(SMODS.find_card('j_mxms_4d')) and mxms_4d_dt_mod > 1 then

        mxms_4d_dt_mod = 0

        for k, v in pairs(G.jokers.cards) do

            if v.config.center.key == 'j_mxms_4d' and v.ability.extra.Xmult > 1 then
                v.ability.extra.Xmult = v.ability.extra.Xmult - 0.01
                v:juice_up(0.1, 0.2)
                if Maximus_config.Maximus.four_d_ticks then
                    play_sound('generic1')
                end

            end

        end

    end
end

-- Jokers

SMODS.Joker { -- Fortune Cookie
    key = 'fortune_cookie',
    loc_txt = {
        name = 'Fortune Cookie',
        text = {'{C:green}#3# out of #4#{} chance to receive', 'a random {C:tarot}Tarot{} card when',
                ' playing a hand {C:inactive}(Must have room){}',
                '{C:inactive}Chance reduces by #1# for every played hand'}
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    perishable_compat = false,
    eternal_compat = false,
    config = {
        extra = {
            chance = 10,
            odds = 10
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {G.GAME.probabilities.normal, center.ability.extra.chance * G.GAME.fridge_mod,
                    center.ability.extra.chance * G.GAME.fridge_mod * G.GAME.probabilities.normal,
                    center.ability.extra.odds * G.GAME.fridge_mod}
        }
    end,
    calculate = function(self, card, context)

        -- Activate ability before scoring if chance is higher than 0
        if context.before and card.ability.extra.chance > 0 then

            -- Roll chance and decrease by 1
            local chance_roll = pseudorandom('fco', 1, 10 * G.GAME.fridge_mod * G.GAME.probabilities.normal)
            local chance_odds = (card.ability.extra.odds - card.ability.extra.chance) * G.GAME.fridge_mod
            card.ability.extra.chance = card.ability.extra.chance - (1 / G.GAME.fridge_mod)

            -- Check if Consumables is full
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

                -- Successful roll
                if (chance_roll >= chance_odds) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            play_sound('tarot1')
                            card:juice_up(0.3, 0.4)

                            local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'fco')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = 0
                            return true;
                        end
                    }))
                    return {
                        card = card,
                        message = 'FORTUNATE!',
                        colour = G.C.SECONDARY_SET.Tarot
                    }

                    -- Failed Roll
                else
                    G.GAME.pessimistic_mult = G.GAME.pessimistic_mult + (10 - card.ability.extra.chance)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            play_sound('tarot2')
                            return true;
                        end
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
                    func = function()
                        play_sound('tarot2')
                        return true;
                    end
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

        -- "Crumble" card after scoring
        if context.after and not context.blueprint then
            if card.ability.extra.chance <= 0 then
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

SMODS.Joker { -- Poindexter
    key = 'poindexter',
    loc_txt = {
        name = "Poindexter",
        text = {'{X:mult,C:white}X0.25{} Mult for every', 'scoring {C:attention}glass card{} that',
                'remains intact; {C:red}Resets{} on break', '{C:inactive}Currently: {X:mult,C:white}X#1#{}'}
    },
    atlas = 'Jokers',
    rarity = 2,
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            Xmult = 1.0,
            shattered = false
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {
            vars = {center.ability.extra.Xmult, center.ability.extra.shattered}
        }
    end,
    calculate = function(self, card, context)

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
                                return true;
                            end
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
    key = 'abyss',
    loc_txt = {
        name = "Abyss",
        text = {'When blind is selected, {C:green}50/50{}', '{C:attention}chance{} of making a currently held',
                'non-negative Joker {C:dark_edition}Negative{} or', 'destroying a currently held non-negative joker',
                '{C:inactive}Can override other editions{}'}
    },
    atlas = 'Jokers',
    rarity = 3,
    pos = {
        x = 2,
        y = 0
    },
    config = {},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then

            -- Store all eligible jokers in table
            -- Code derived Madness
            local eligible_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and
                    not (G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative) and
                    not G.jokers.cards[i].getting_sliced then
                    eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                end
            end

            -- Fail if no held jokers are eligible
            if next(eligible_jokers) == nil then
                return {
                    extra = {
                        message = 'No target...',
                        colour = G.C.PURPLE
                    }
                }
            else
                -- Choose Joker to affect
                local chosen_joker =
                    #eligible_jokers > 0 and pseudorandom_element(eligible_jokers, pseudoseed('abyss')) or nil

                -- "Flip a coin" to decide what to do with the target
                local flip = pseudorandom('aby', 1, 2)

                -- Add negative edition to random held joker
                if flip == 1 then
                    card:juice_up(0.3, 0.4)
                    chosen_joker:set_edition({
                        negative = true
                    }, true)
                    return {
                        extra = {
                            message = 'Void-touched!',
                            colour = G.C.PURPLE
                        }
                    }

                    -- Destroy a random non-negative joker
                elseif flip == 2 then

                    -- Double check the target is not self
                    -- Code derived Madness
                    if chosen_joker and not (context.blueprint_card or card).getting_sliced then
                        chosen_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                chosen_joker:start_dissolve({G.C.PURPLE}, nil, 1.6)
                                return true;
                            end
                        }))
                    end
                    return {
                        extra = {
                            message = 'Consumed',
                            colour = G.C.PURPLE
                        }
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- War
    key = 'war',
    loc_txt = {
        name = 'War',
        text = {'Means of destroying cards', 'have their limits {C:attention}doubled{}'}
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 3,
    config = {},
    add_to_deck = function(self, card, from_debuff)
        G.GAME.war_mod = G.GAME.war_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.war_mod = G.GAME.war_mod / 2
    end
}

SMODS.Joker { -- Microwave
    key = 'microwave',
    loc_txt = {
        name = 'Microwave',
        text = {'{C:red}Food{} Jokers are', '{C:attention}retriggered'}
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 0
    },
    rarity = 2,
    config = {},
    calculate = function(self, card, context)

        -- Thank you to theonegoodali from the Balatro Discord for helping me with this conditional
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.ability then
            for i = 1, #food_jokers do
                if context.other_card.ability.name == food_jokers[i].name and food_jokers[i].name ~= 'Leftovers' then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Combo Breaker
    key = 'combo_breaker',
    loc_txt = {
        name = 'Combo Breaker',
        text = {'Gains {X:mult,C:white}X0.5{} Mult', 'per retrigger',
                '{C:inactive}Starts at {X:mult,C:white}X1{} Mult, resets every hand{}'}
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 1
    },
    rarity = 3,
    config = {
        extra = {
            Xmult = 1.0,
            retriggers = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.Xmult, center.ability.extra.retriggers}
        }
    end,

    calculate = function(self, card, context)

        if (context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card) or
            (context.cardarea == G.play and context.repetition and context.other_card.seal == 'Red') then
            -- Add retrigger to total
            card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            return {
                repetitions = 0,
                card = card
            }
        end

        if context.joker_main and card.ability.extra.retriggers > 0 then
            -- Add retrigger count and multiply by 0.5 for mult 
            card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.retriggers * 0.5)

            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('mxms_perfect')
                    return true;
                end
            }))

            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'x' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before or context.after then
            card.ability.extra.retriggers = 0
            card.ability.extra.Xmult = 1.0
        end
    end
}

SMODS.Joker { -- Faded
    key = 'faded',
    loc_txt = {
        name = 'Faded Joker',
        text = {'{C:diamonds}Diamonds{} and {C:spades}Spades{}', 'count as the same suit,',
                '{C:hearts}Hearts{} and {C:clubs}Clubs{}', 'count as the same suit'}
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 1
    },
    rarity = 2,
    config = {}
}

SMODS.Joker { -- Old Man Jimbo
    key = 'old_man_jimbo',
    loc_txt = {
        name = 'Old Man Jimbo',
        text = {'{X:mult,C:white}X1{} Mult plus {X:mult,C:white}X0.5{}', 'for each remaining hand'}
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 1
    },
    rarity = 2,
    config = {},

    calculate = function(self, card, context)
        if context.joker_main then
            local Xmult = 1 + (0.5 * G.GAME.current_round.hands_left)
            return {
                Xmult_mod = Xmult,
                message = 'x' .. Xmult,
                colour = G.C.MULT
            }
        end
    end
}

SMODS.Joker { -- Joker+
    key = 'joker_plus',
    loc_txt = {
        name = 'Joker+',
        text = {'{C:mult}+5{} Mult'}
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 1
    },
    rarity = 3,
    config = {
        extra = {
            mult = 5
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.mult}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
}

SMODS.Joker { -- Normal Joker
    key = 'normal',
    loc_txt = {
        name = 'Normal Joker',
        text = {'Played cards without an', 'enchancement, edition, or seal',
                ' give {C:mult}+1{} Mult and {C:chips}+5{} Chips'}
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 1
    },
    rarity = 1,
    config = {},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.other_card.edition and not context.other_card.seal and not context.other_card.enhancement then
                return {
                    mult = 1,
                    chips = 5
                }
            end
        end
    end
}

SMODS.Joker { -- Streaker
    key = 'streaker',
    loc_txt = {
        name = 'Streaker',
        text = {'{C:chips}+30{} Chips and {C:mult}+15{} Mult', 'for each consecutive {C:attention}blind{}',
                'beaten in {C:attention}one hand{}, {C:red}Resets{}', 'when streak is broken',
                '{C:inactive}Current streak: #1#',
                '{C:inactive}Currently: {C:chips}+#3# {C:inactive}Chips, {C:mult}+#4#{} Mult'}
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            streak = 0,
            hands = 0, -- I know there's an tracker in vanilla but I can't access it at context.end_of_round
            chips = 0,
            mult = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.streak, center.ability.extra.hands, center.ability.extra.chips,
                    center.ability.extra.mult}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main and card.ability.extra.streak > 0 then
            return {
                mult_mod = card.ability.extra.chips,
                chip_mod = card.ability.extra.mult,
                message = 'Streaked!',
                colour = G.C.MULT
            }
        end

        if context.before and not context.blueprint then
            card.ability.extra.hands = card.ability.extra.hands + 1
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if card.ability.extra.hands == 1 then
                card.ability.extra.hands = 0
                card.ability.extra.streak = card.ability.extra.streak + 1
                card.ability.extra.chips = 30 * card.ability.extra.streak
                card.ability.extra.mult = 15 * card.ability.extra.streak
                return {
                    message = 'Streak ' .. card.ability.extra.streak,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                card.ability.extra.streak = 0
                card.ability.extra.hands = 0
                card.ability.extra.chips = 0
                card.ability.extra.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker { -- Jobber
    key = 'jobber',
    loc_txt = {
        name = 'Jobber',
        text = {'If hand is played with only', '{C:red}debuffed{} cards, destroy this',
                'Joker and create a random copy', 'of another held Joker', '{C:inactive}Removes negative from copy'}
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 0
    },
    rarity = 3,
    blueprint_compat = false,
    calculate = function(self, card, context)

        if context.before and not context.blueprint then

            -- Check if played hand is all debuffed cards
            local all_debuffed = true
            for i = 1, #context.scoring_hand do
                if not context.scoring_hand[i].debuff then
                    all_debuffed = false
                    break
                end
            end

            -- Fail if not all debuffed
            if not all_debuffed then
                return

            else
                -- Store all eligible jokers in table
                -- Code derived Madness
                local eligible_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card then
                        eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                    end
                end

                -- Fail if no held jokers are eligible
                if next(eligible_jokers) == nil then
                    return {
                        extra = {
                            message = 'No target...',
                            colour = G.C.PURPLE
                        },
                        card = card
                    }
                else

                    -- Destroy Jobber
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve({G.C.YELLOW}, nil, 1.6)
                            return true;
                        end
                    }))
                end

                -- Choose Joker to copy
                local chosen_joker = #eligible_jokers > 0 and
                                         pseudorandom_element(eligible_jokers, pseudoseed('jobber')) or nil

                -- Copy Joker and add to hand
                local new_card = copy_card(chosen_joker, nil, nil, nil,
                    chosen_joker.edition and chosen_joker.edition.negative)
                new_card:start_materialize()
                new_card:add_to_deck()
                if new_card.edition and new_card.edition.negative then
                    new_card:set_edition(nil, true)
                end
                G.jokers:emplace(new_card)
                return {
                    extra = {
                        message = 'Jobbed',
                        colour = G.C.YELLOW
                    },
                    card = card
                }
            end
        end
    end
}

SMODS.Joker { -- Astigmatism
    key = 'astigmatism',
    loc_txt = {
        name = 'Astigmatism',
        text = {'{X:chips,C:white}x2{} Chips'}
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 0
    }, -- Change once sprite art is added
    rarity = 3,
    config = {},
    calculate = function(self, card, context)

        if context.joker_main then
            return {
                chip_mod = hand_chips,
                message = 'x2',
                colour = G.C.CHIPS
            }
        end

    end
}

SMODS.Joker { -- Perspective
    key = 'perspective',
    loc_txt = {
        name = 'Perspective',
        text = {'{C:attention}6\'s{} count as {C:attention}9\'s{}', 'and vice-versa'}
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 0
    },
    rarity = 1,
    config = {}
}

SMODS.Joker { -- Harmony
    key = 'harmony',
    loc_txt = {
        name = 'Harmony',
        text = {'{C:mult}+16{} Mult if played', 'hand contains an Ace and a 2'}
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 1
    },
    rarity = 1,
    config = {
        extra = {
            mult = 16
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.mult}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main then
            local aces, twos = 0, 0

            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 then
                    aces = aces + 1
                end
                if context.scoring_hand[i]:get_id() == 14 then
                    twos = twos + 1
                end
            end

            if aces > 0 and twos > 0 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = '+' .. card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker { -- Impractical Joker
    key = 'impractical_joker',
    loc_txt = {
        name = 'Impractical Joker',
        text = {'If a {C:attention}#2#{} is played,', '{X:mult,C:white}X3{} Mult. If three hands in a',
                'row are not this hand type, {X:mult,C:white}X0.5{} Mult', '{C:inactive}Hand rotates every round',
                '{C:inactive}Fail streak: #1#'}
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            fails = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.fails, G.GAME.current_round.impractical_hand}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main then

            -- If correct hand is played
            if context.scoring_name == G.GAME.current_round.impractical_hand then

                if not context.blueprint then
                    card.ability.extra.fails = 0
                end

                return {
                    message = 'x3',
                    Xmult_mod = 3,
                    colour = G.C.MULT
                }

                -- If incorrect hand is played
            else

                if not context.blueprint then
                    card.ability.extra.fails = card.ability.extra.fails + 1
                end

                -- If below 3 fails
                if card.ability.extra.fails < 3 then
                    return {
                        message = 'Fail ' .. card.ability.extra.fails,
                        colour = G.C.RED
                    }

                    -- If 3 fails
                elseif card.ability.extra.fails == 3 then
                    return {
                        message = 'Tonight\'s Biggest Loser',
                        Xmult_mod = 0.5,
                        colour = G.C.RED
                    }
                end
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.fails = 0
            return {
                message = localize('k_reset'),
                colour = G.C.CHIPS
            }
        end
    end
}

SMODS.Joker { -- Trick or Treat
    key = 'trick_or_treat',
    loc_txt = {
        name = 'Trick or Treat',
        text = {'When held, {C:attention}Booster packs{}', 'now let you take one more', 'card than usual'}
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            mult = 5
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.mult}
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.choose_mod = G.GAME.choose_mod + 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.choose_mod = G.GAME.choose_mod - 1
    end,
    calculate = function(self, card, context)

        if context.open_booster then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    card:juice_up(0.3, 0.4)
                    return true
                end)
            }))
        end

    end
}

SMODS.Joker { -- Pessimistic Joker
    key = 'pessimistic',
    loc_txt = {
        name = 'Pessimistic Joker',
        text = {'After each failed probability check,', 'this Joker gains {C:mult}Mult{} equal to the',
                'odds of failing the check', '{C:inactive}+3 for missed Lucky Card',
                '{C:inactive}Currently: {C:mult}+#1# {C:inactive}Mult'}
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.mult}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end

        if context.individual and context.other_card.ability.effect == 'Lucky Card' and
            not context.other_card.lucky_trigger and not context.blueprint then
            G.GAME.pessimistic_mult = G.GAME.pessimistic_mult + 3
            card:juice_up(0.3, 0.4)
        end
    end
}

SMODS.Joker { -- Chef
    key = 'chef',
    loc_txt = {
        name = 'Chef',
        text = {'Creates a random {C:attention}Food{} Joker', 'when blind is selected'}
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 2
    },
    rarity = 1,
    calculate = function(self, card, context)

        if context.setting_blind then
            -- Check if there is space for a new joker
            if #G.jokers.cards >= G.jokers.config.card_limit then
                return

            else
                local chosen_joker = nil
                while not chosen_joker or
                    (chosen_joker.name == 'Cavendish' and not G.GAME.pool_flags.gros_michel_extinct) do
                    chosen_joker = pseudorandom_element(food_jokers, pseudoseed('chef'))
                end
                local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_joker.key, 'chef')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end

    end
}

SMODS.Joker { -- Leftovers
    key = 'leftovers',
    loc_txt = {
        name = 'Leftovers',
        text = {'Creates a new copy of', 'a {C:attention}Food{} Joker when', 'depleated or destroyed',
                '{C:inactive}Self-destructs on copy{}'}
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 2
    },
    blueprint_compat = false,
    rarity = 1,
    calculate = function(self, card, context)

        if G.GAME.destroyed_food ~= '' and not context.blueprint then
            local respawn_key = G.GAME.destroyed_food
            G.GAME.destroyed_food = ''

            G.E_MANAGER:add_event(Event({
                delay = 0.3,
                func = function()
                    play_sound('timpani')

                    local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, respawn_key, 'lefto')
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)

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
                message = 'Saved for later!'
            }
        end
    end
}

SMODS.Joker { -- Refrigerator
    key = 'refrigerator',
    loc_txt = {
        name = 'Refrigerator',
        text = {'{C:attention}Food{} Jokers degrade', 'half as fast'}
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            mult = 5
        }
    },
    add_to_deck = function(self, card, from_debuff)
        G.GAME.fridge_mod = G.GAME.fridge_mod + 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.fridge_mod = G.GAME.fridge_mod - 1
    end
}

SMODS.Joker { -- Hopscotch
    key = 'hopscotch',
    loc_txt = {
        name = 'Hopscotch',
        text = {'When selecting blind,', '{C:green}1 out of 3{} chance to', 'receive associated skip tag'}
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 2
    },
    rarity = 2,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {G.GAME.probabilities.normal}
        }
    end,
    calculate = function(self, card, context)

        if context.setting_blind and not G.GAME.blind:get_type() == 'Boss' then

            if pseudorandom('hopscotch', G.GAME.probabilities.normal, 3) == 3 then

                -- Code derived from G.FUNCS.skip_blind
                local _tag = G.GAME.skip_tag
                if _tag then
                    play_sound('generic1')
                    card:juice_up(0.3, 0.4)
                    add_tag(_tag.config.ref_table)
                    G.GAME.skip_tag = ''
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            delay(0.3)
                            save_run()
                            for i = 1, #G.GAME.tags do
                                G.GAME.tags[i]:apply_to_run({
                                    type = 'immediate'
                                })
                            end
                            for i = 1, #G.GAME.tags do
                                if G.GAME.tags[i]:apply_to_run({
                                    type = 'new_blind_choice'
                                }) then
                                    break
                                end
                            end
                            return true
                        end
                    }))
                end
            elseif next(SMODS.find_card('j_mxms_pessimistic')) then
                G.GAME.pessimistic_mult = G.GAME.pessimistic_mult + (3 - G.GAME.probabilities.normal)
            end
        end
    end
}

SMODS.Joker { -- Secret Society
    key = 'secret_society',
    loc_txt = {
        name = 'Secret Society',
        text = {'{C:chips}Chip{} values of ranks', 'are {C:attention}swapped and doubled{}'}
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 2
    },
    rarity = 2,
    config = {}
}

SMODS.Joker { -- Bullseye
    key = 'bullseye',
    loc_txt = {
        name = 'bullseye',
        text = {'If {C:attention}blind\'s{} Chip requirement', 'is met {C:attention}exactly{}, this joker',
                'gains {C:chips}+#1#{} Chips', '{C:inactive}Scales with round', '{C:inactive}Currently: {C:chips}+#2#'}
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {100 * G.GAME.round, center.ability.extra.chips}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and
            G.GAME.blind.chips == G.GAME.chips then
            card.ability.extra.chips = card.ability.extra.chips + (100 * G.GAME.round)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end

    end
}

SMODS.Joker { -- Hammer and Chisel
    key = 'hammer_and_chisel',
    loc_txt = {
        name = 'Hammer and Chisel',
        text = {'Stone cards retain', '{C:attention}rank{} and {C:attention}suit{}'}
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 2
    },
    rarity = 2,
    config = {}
}

SMODS.Joker { -- Four-Leaf Clover
    key = 'four_leaf_clover',
    loc_txt = {
        name = 'Four-Leaf Clover',
        text = {'If scored hand has exactly 4 cards,', 'convert them all to {C:attention}Lucky{}'}
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 2
    },
    rarity = 2,
    config = {},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return {
            vars = {}
        }
    end,
    blueprint_compat = false,
    calculate = function(self, card, context)

        if context.before and not context.blueprint and #context.scoring_hand == 4 then

            -- Code derived from Midas Mask
            for k, v in ipairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS.m_lucky, nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end

            return {
                message = 'Lucky',
                colour = G.C.GREEN,
                card = card
            }

        end

    end
}

SMODS.Joker { -- Soyjoke
    key = 'soyjoke',
    loc_txt = {
        name = 'Soyjoke',
        text = {'{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X1{} Mult', 'every time a Joker', 'is repurchased'}
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 2
    },
    rarity = 2,
    config = {},
    loc_vars = function(self, info_queue, center)
        return {
            vars = {G.GAME.soy_mod}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main and G.GAME.soy_mod > 1 then
            return {
                Xmult_mod = G.GAME.soy_mod,
                message = 'x' .. G.GAME.soy_mod,
                colour = G.C.MULT
            }
        end

    end
}

SMODS.Joker { -- Clown Car
    key = 'clown_car',
    loc_txt = {
        name = 'Clown Car',
        text = {'Gains {C:mult}+10{} Mult each time', 'a Joker is added to hand', '{C:inactive}Currently: +#1#'}
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.mult}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end

    end
}

SMODS.Joker { -- Gambler
    key = 'gambler',
    loc_txt = {
        name = 'Gambler',
        text = {'Capped sources of money generation', 'have their limits {C:attention}doubled{}'}
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 3
    },
    rarity = 2,
    config = {},
    add_to_deck = function(self, card, from_debuff)
        G.GAME.gambler_mod = G.GAME.gambler_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.gambler_mod = G.GAME.gambler_mod / 1
    end
}

SMODS.Joker { -- 4D
    key = '4d',
    loc_txt = {
        name = '4D Joker',
        text = {'{X:mult,C:white}X#1#{} Mult,', 'decreases by {X:mult,C:white}X0.01{}', 'every second'}
    },
    atlas = '4D',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 7
    },
    rarity = 2,
    perishable_compat = false,
    eternal_compat = false,
    config = {
        extra = {
            Xmult = 4
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.Xmult}
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'x' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end

        if card.ability.extra.Xmult <= 1 then

            card:start_dissolve({G.C.BLUE}, nil, 1.6)

        end

    end
}