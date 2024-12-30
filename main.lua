SMODS.Atlas{
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

-- Set fallbacks
local igo = Game.init_game_object
Game.init_game_object = function(self)
  local ret = igo(self)
  ret.current_round.impractical_hand = 'High Card'
  return ret
end

-- Jokers

SMODS.Joker { -- Fortune Cookie
    key = 'fortune_cookie',
    loc_txt = {
        name = 'Fortune Cookie',
        text = {
            '{C:attention}#3# out of 10{} chance to receive',
            'a random {C:tarot}Tarot{} card when',
            ' playing a hand {C:inactive}(Must have room){}',
            '{C:inactive}Chance reduces by #1# for every played hand'
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
        
        -- Activate ability before scoring if chance is higher than 0
        if context.before and card.ability.extra.chance > 0 then

            -- Roll chance and decrease by 1
            local chance_roll = pseudorandom('fco', 1, 10 * G.GAME.probabilities.normal)
            local chance_odds = 10 - card.ability.extra.chance
            card.ability.extra.chance = card.ability.extra.chance - 1

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

                            local new_card = create_card('Tarot', G.consumeables, nil,nil,nil,nil,nil,'fco')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = 0
                        return true; end
                    }))
                    return {
                        card = card,
                        message = 'FORTUNATE!',
                        colour = G.C.SECONDARY_SET.Tarot
                    }

                -- Failed Roll
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

        -- "Crumble" card after scoring
        if context.after and not context.blueprint then
            if card.ability.extra.chance < 1 then
                --Code derived from Gros Michel/Cavendish
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
            '{C:mult}x0.25{} mult for every',
            'scoring {C:attention}glass card{} that',
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
            '{C:attention}chance{} of making a currently held',
            'non-negative Joker {C:dark_edition}Negative{} or',
            'destroying a currently held non-negative joker',
            '{C:inactive}Can override other editions{}'
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

            -- Store all eligible jokers in table
                -- Code derived Madness
            local eligible_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not(G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative) and not G.jokers.cards[i].getting_sliced then 
                    eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i] 
                end
            end

            -- Fail if no held jokers are eligible
            if next(eligible_jokers) == nil then
                return {
                    extra = {message = 'No target...', colour = G.C.PURPLE}
                }
            else 
            -- Choose Joker to affect
            local chosen_joker = #eligible_jokers > 0 and pseudorandom_element(eligible_jokers, pseudoseed('abyss')) or nil

            -- "Flip a coin" to decide what to do with the target
            local flip = pseudorandom('aby', 1, 2)

            -- Add negative edition to random held joker
            if flip == 1 then
                card:juice_up(0.3, 0.4)
                chosen_joker:set_edition({negative = true}, true)
                return {
                    extra = {message = 'Void-touched!', colour = G.C.PURPLE}
                }
                
            -- Destroy a random non-negative joker
            elseif flip == 2 then

                --Double check the target is not self
                    -- Code derived Madness
                if chosen_joker and not (context.blueprint_card or card).getting_sliced then                            chosen_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            (context.blueprint_card or card):juice_up(0.8, 0.8)
                            chosen_joker:start_dissolve({G.C.PURPLE}, nil, 1.6)
                            return true; 
                        end}))
                    end
                    return{
                        extra = {message = 'Cosumed', colour = G.C.PURPLE}
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
        text = {
            'All even cards are',
            'treated as {C:attention}the same card{},',
            'all odd cards are',
            'treated as {C:attention}the same card{}'
        }
    },
    atlas = 'Jokers',
    pos = {x = 3, y = 0},
    rarity = 3,
    config = {}
}

SMODS.Joker { -- Microwave
    key = 'microwave',
    loc_txt = {
        name = 'Microwave',
        text = {
            '{C:red}Perishable{} Jokers are',
            '{C:attention}retriggered'
        }
    },
    atlas = 'Jokers',
    pos = {x = 4, y = 0},
    rarity = 3,
    config = {},
    calculate = function(self,card,context)

        -- Thank you to theonegoodali from the Balatro Discord for helping me with this conditional
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.ability and context.other_card.ability.perishable then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Combo Breaker
    key = 'combo_breaker',
    loc_txt = {
        name = 'Combo Breaker',
        text = {
            'Gains {C:mult}0.5x{} mult',
            'per retrigger in a played hand',
            '{C:inactive}Starts at 1x mult, resets every hand{}'
        }
    },
    atlas = 'Jokers',
    pos = {x = 0, y = 1},
    rarity = 3,
    config = { extra = {
        Xmult = 1.0,
        retriggers = 0
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.retriggers}}
    end,

    calculate = function(self,card,context)

        if context.scoring_hand and context.repetition and not context.blueprint then
            if context.cardarea == G.play or context.cardarea == G.hand then
                -- Add retrigger to total
                card.ability.extra.retriggers = card.ability.extra.retriggers + 1
                return {
                    message = '+ 0.5x',
                    repetitions = 0,
                    card = card
                }
            end
        end

        if context.joker_main then
            -- Add retrigger count and multiply by 0.5 for mult 
            card.ability.extra.Xmult =  card.ability.extra.Xmult + (card.ability.extra.retriggers * 0.5)
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'x' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.after then 
            card.ability.extra.retriggers = 0
            card.ability.extra.Xmult = 1
        end
    end
}

SMODS.Joker { -- Faded
    key = 'faded',
    loc_txt = {
        name = 'Faded',
        text = {
            '{C:diamonds}Diamonds{} and {C:spades}spades{}',
            'are treated as the same suit,',
            '{C:hearts}hearts{} and {C:clubs}clubs{}',
            'are treated as the same suit'
        }
    },
    atlas = 'Jokers',
    pos = {x = 1, y = 1},
    rarity = 2,
    config = {}
}

SMODS.Joker { -- Old Man Jimbo
    key = 'old_man_jimbo',
    loc_txt = {
        name = 'Old Man Jimbo',
        text = {
            '{C:mult}x1{} mult plus {C:mult}x0.5{}',
            'for each remaining hand'
        }
    },
    atlas = 'Jokers',
    pos = {x = 2, y = 1},
    rarity = 3,
    config = {},

    calculate = function(self,card,context)
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
        text = {
            '{C:mult}+5{} mult'
        }
    },
    atlas = 'Jokers',
    pos = {x = 3, y = 1},
    rarity = 3,
    config = { extra = {
        mult = 5
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}}
    end,
    calculate = function(self,card,context)
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
    key = 'normal_joker',
    loc_txt = {
        name = 'Normal Joker',
        text = {
            'Played cards without an enchancement,',
            'edition, or seal give {C:mult}+1{} mult and {C:chips}+5{} chips'
        }
    },
    atlas = 'Jokers',
    pos = {x = 4, y = 1},
    rarity = 1,
    config = {},
    calculate = function(self,card,context)
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
        text = {
            '{C:chips}+30{} chips and {C:mult}+15{} mult',
            'for each consecutive {C:attention}blind{}',
            'beaten in {C:attention}one hand{}, {C:red}Resets{}',
            'when streak is broken',
            '{C:inactive}Current streak: #1#',
            '{C:inactive}Total: +#3# chips +#4# mult'
        }
    },
    atlas = 'Jokers',
    pos = {x = 5, y = 0},
    rarity = 3,
    config = { extra = {
        streak = 0,
        hands = 0, -- I know there's an tracker in vanilla but I can't access it at context.end_of_round
        chips = 0,
        mult = 0,    
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.streak, center.ability.extra.hands, center.ability.extra.chips, center.ability.extra.mult}}
    end,
    calculate = function(self,card,context)

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
        text = {
            'If hand is played with only',
            '{C:red}debuffed{} cards, destroy this',
            'Joker and create a random copy',
            'of another held Joker',
            '{C:inactive}Removes negative from copy'
        }
    },
    atlas = 'Jokers',
    pos = {x = 6, y = 0},
    rarity = 3,
    blueprint_compat = false,
    calculate = function(self,card,context)

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
                        extra = {message = 'No target...', colour = G.C.PURPLE},
                        card = card
                    }
                else 

                -- Destroy Jobber
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve({G.C.YELLOW}, nil, 1.6)
                        return true; 
                    end}))
                end

                -- Choose Joker to copy
                local chosen_joker = #eligible_jokers > 0 and pseudorandom_element(eligible_jokers, pseudoseed('jobber')) or nil

                -- Copy Joker and add to hand
                local new_card = copy_card(chosen_joker, nil, nil, nil, chosen_joker.edition and chosen_joker.edition.negative)
                new_card:start_materialize()
                new_card:add_to_deck()
                if new_card.edition and new_card.edition.negative then
                    new_card:set_edition(nil, true)
                end
                G.jokers:emplace(new_card)               
                return {
                    extra = {message = 'Jobbed', colour = G.C.YELLOW},
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
        text = {
            '{C:chips}x2{} chips'
        }
    },
    atlas = 'Jokers',
    pos = {x = 7, y = 0}, -- Change once sprite art is added
    rarity = 3,
    config = {},
    calculate = function(self,card,context)

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
        text = {
            '6\'s count as 9\'s',
            'and vice-versa'
        }
    },
    atlas = 'Jokers',
    pos = {x = 8, y = 0},
    rarity = 1,
    config = {}
}

SMODS.Joker { -- Harmony
    key = 'harmony',
    loc_txt = {
        name = 'Harmony',
        text = {
            '{C:mult}+16{} mult if played',
            'hand contains an Ace and a 2'
        }
    },
    atlas = 'Jokers',
    pos = {x = 5, y = 1},
    rarity = 3,
    config = { extra = {
        mult = 16
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}}
    end,
    calculate = function(self,card,context)

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
        text = {
            'If a {C:attention}#2#{} is played,',
            '{C:mult}x3{} mult. If three hands in a',
            'row are not this hand type, {C:mult}0.5x{} mult',
            '{C:inactive}Fail streak: #1#'
        }
    },
    atlas = 'Jokers',
    pos = {x = 6, y = 1},
    rarity = 1,
    config = { extra = {
        fails = 0
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.fails, G.GAME.current_round.impractical_hand}}
    end,
    calculate = function(self,card,context)

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

                if not context.blueprint  then
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

-- Misc Variables
function SMODS.current_mod.reset_game_globals(run_start) 
    
    -- Impractical Joker
    G.GAME.current_round.impractical_hand = G.GAME.current_round.impractical_hand
    local valid_hands = {}

    for k, v in pairs(G.GAME.hands) do
        if v.visible then valid_hands[#valid_hands+1] = k end
    end

    local new_hand = G.GAME.current_round.impractical_hand
    while new_hand == G.GAME.current_round.impractical_hand do
        new_hand = pseudorandom_element(valid_hands, pseudoseed('impractical'.. G.GAME.round_resets.ante))
    end
    G.GAME.current_round.impractical_hand = new_hand

end