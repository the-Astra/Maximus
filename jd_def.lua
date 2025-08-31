local jd_def = JokerDisplay.Definitions

jd_def['j_mxms_4d'] = { -- 4D Joker
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_abyss_angel'] = { -- Abyss Angel
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "accrued_chips", colour = G.C.CHIPS },
        { text = "/" },
        { ref_table = "card.ability.extra",        ref_value = "target_chips" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.accrued_chips = card.ability.extra.accrued_chips
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            local aChips = 0
            for k, v in pairs(scoring_hand) do
                aChips = (aChips + v:get_chip_bonus()) * JokerDisplay.calculate_card_triggers(v, scoring_hand)
            end
            card.joker_display_values.accrued_chips = card.joker_display_values.accrued_chips + aChips
        end
    end
}

jd_def['j_mxms_bankrupt'] = { -- Bankrupt
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 }
}

jd_def['j_mxms_bear'] = { -- Bear
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = 1
        if to_big(G.GAME.dollars) < to_big(0) then
            card.joker_display_values.Xmult = card.joker_display_values.Xmult +
                math.abs(G.GAME.dollars) * card.ability.extra.gain
        end
    end
}

jd_def['j_mxms_bell_curve'] = { -- Bell Curve
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_blackjack'] = { -- Blackjack
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_blue_tang'] = { -- Blue Tang
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        if card ~= G.jokers.cards[#G.jokers.cards] then
            card.joker_display_values.active = localize('jdis_active')
        else
            card.joker_display_values.active = localize('jdis_inactive')
        end
    end
}

jd_def['j_mxms_bootleg'] = { -- Bootleg
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "copied_card", colour = G.C.RED },
        { text = ")" },
    },
    calc_function = function(card)
        local copied_joker, copied_debuff = JokerDisplay.calculate_blueprint_copy(card)
        card.joker_display_values.copied_card = localize('k_none')
        JokerDisplay.copy_display(card, copied_joker, copied_debuff)
    end,
    get_blueprint_joker = function(card)
        if G.GAME.mxms_last_bought.card ~= nil then
            return G.GAME.mxms_last_bought.card
        end
        return nil
    end
}

jd_def['j_mxms_brainwashed'] = { -- Brainwashed
    text = {
        { ref_table = "card.joker_display_values", ref_value = "suit" }
    },
    extra = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'bwash')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }

        card.joker_display_values.suit = localize('k_none')
        card.joker_display_values.suit_key = nil
        local _, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
        if poker_hands['Flush'] and next(poker_hands['Flush']) then
            card.joker_display_values.suit = localize(scoring_hand[1].base.suit, 'suits_singular')
            card.joker_display_values.suit_key = scoring_hand[1].base.suit
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if card.joker_display_values.suit_key then
            text.children[1].config.colour = lighten(G.C.SUITS[card.joker_display_values.suit_key], 0.35)
        else
            text.children[1].config.colour = G.C.WHITE
        end
    end
}

jd_def['j_mxms_breadsticks'] = { -- Endless Breadsticks
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "d_tally",      colour = G.C.RED },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "d_requirement" },
        { text = ")" },
    }
}

jd_def['j_mxms_brown'] = { -- Brown
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_bullseye'] = { -- Bullseye
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 }
}

jd_def['j_mxms_butterfly'] = { -- Butterfly
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "consumables", colour = G.C.SPECTRAL },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "goal" },
        { text = ")" },
    }
}

jd_def['j_mxms_caterpillar'] = { -- caterpillar
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "tarots", colour = G.C.TAROT },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "goal" },
        { text = ")" },
    }
}

jd_def['j_mxms_chekhov'] = { -- Chekhov's Gun
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = 1
        card.joker_display_values.active = localize('jdis_inactive')
        if G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown then
            card.joker_display_values.Xmult = G.GAME.round_resets.blind_ante
            card.joker_display_values.active = localize('jdis_active')
        end
    end
}

jd_def['j_mxms_chrysalis'] = { -- Chrysalis
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "planets", colour = G.C.PLANET },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "goal" },
        { text = ")" },
    }
}

jd_def['j_mxms_clown_car'] = { -- Clown Car
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 }
}

jd_def['j_mxms_comedian'] = { -- Comedian
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    extra = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'comedian')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_conveyor_belt'] = { -- Convyeor Belt
    text = {
        { text = "+",                       colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +",                      colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
    },
}

jd_def['j_mxms_coronation'] = { -- Coronation
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "rounds", colour = G.C.ATTENTION },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "goal" },
        { text = ")" },
    }
}

jd_def['j_mxms_coupon'] = { -- Coupon
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.4 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'cou')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_crowned'] = { -- Crowned
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_dark_room'] = { -- Dark Room
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "rounds", colour = G.C.ATTENTION },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "req" },
        { text = ")" },
    }
}

jd_def['j_mxms_dmiid'] = { -- Don't Mind If I Do
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_fools_gold'] = { -- Fool's Gold
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "dollars" },
    },
    text_config = { colour = G.C.GOLD, scale = 0.4 },
    calc_function = function(card)
        local gold_cards = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_gold') then
                    gold_cards = gold_cards + 1
                end
            end
        end

        card.joker_display_values.dollars = math.floor(gold_cards / 2)
    end
}

jd_def['j_mxms_fortune_cookie'] = { -- Fortune Cookie
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.4 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'fco')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_four_course_meal'] = { -- Four Course Meal
    text = {
        { ref_table = "card.joker_display_values", ref_value = "value" },
    },
    calc_function = function(card)
        if card.ability.extra.hands < 1 then
            card.joker_display_values.value = '+' .. card.ability.extra.chips
            return
        elseif card.ability.extra.hands < 2 then
            card.joker_display_values.value = '+' .. card.ability.extra.mult
            return
        elseif card.ability.extra.hands < 3 then
            card.joker_display_values.value = 'X' .. card.ability.extra.Xmult
            return
        elseif card.ability.extra.hands < 4 then
            card.joker_display_values.value = '+$' .. card.ability.extra.money
            return
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1].config.colour then
            if card.ability.extra.hands < 1 then
                text.children[1].config.colour = lighten(G.C.CHIPS, 0.35)
                return
            elseif card.ability.extra.hands < 2 then
                text.children[1].config.colour = lighten(G.C.MULT, 0.35)
                return
            elseif card.ability.extra.hands < 3 then
                text.children[1].config.colour = lighten(G.C.MULT, 0.35)
                return
            elseif card.ability.extra.hands < 4 then
                text.children[1].config.colour = lighten(G.C.GOLD, 0.35)
                return
            end
        end
    end
}

jd_def['j_mxms_four_leaf_clover'] = { -- Four Leaf Clover
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            card.joker_display_values.active = #scoring_hand == 4 and localize('jdis_active') or
                localize('jdis_inactive')
        end
    end
}

jd_def['j_mxms_galaxy_brain'] = { -- Galaxy Brain
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "hand" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = card.ability.extra.Xmult
        card.joker_display_values.hand = localize(card.ability.extra.last_hand, 'poker_hands') or localize('k_none')
        local text, _, _ = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for k, v in pairs(G.GAME.hands) do
                if k == card.ability.extra.last_hand then
                    card.joker_display_values.Xmult = 1
                elseif k == text then
                    card.joker_display_values.Xmult = card.ability.extra.Xmult +
                        card.ability.extra.gain * G.GAME.mxms_soil_mod
                end
            end
        end
    end
}

jd_def['j_mxms_review'] = { -- Game Review
    reminder_text = {
        { text = "(6,7,8,9,10)" },
    },
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return (playing_card:get_id() == 6 or playing_card:get_id() == 7 or
                playing_card:get_id() == 8 or playing_card:get_id() == 9 or
                playing_card:get_id() == 10) and
            joker_card.ability.extra.reps * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}

jd_def['j_mxms_gelatin'] = { -- Gelatin
    text = {
        { ref_table = "card.ability.extra", ref_value = "cards_left" }
    },
    text_config = { colour = G.C.ORANGE, scale = 0.4 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "jello_suit" },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.jello_suit = localize(G.GAME.current_round.mxms_jello_suit, 'suits_singular')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] and G.C.SUITS[G.GAME.current_round.mxms_jello_suit] then
            reminder_text.children[2].config.colour = lighten(G.C.SUITS[G.GAME.current_round.mxms_jello_suit], 0.35)
        end
        return false
    end
}

jd_def['j_mxms_glass_cannon'] = { -- Glass Cannon
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "hands", colour = G.C.RED },
        { text = "/2" },
        { text = ")" },
    }
}

jd_def['j_mxms_go_fish'] = { -- Go Fish
    text = {
        { ref_table = "card.joker_display_values", ref_value = "go_fish_mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "go_fish_rank", colour = G.C.ORANGE },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.go_fish_mult = G.GAME.current_round.mxms_go_fish.mult
        card.joker_display_values.go_fish_rank = G.GAME.current_round.mxms_go_fish.rank
    end
}

jd_def['j_mxms_god_hand'] = { -- God Hand
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "rank", colour = G.C.ORANGE },
        { text = " of " },
        { ref_table = "card.joker_display_values", ref_value = "suit" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = card.ability.extra.bad_Xmult
        for k, v in pairs(G.hand.cards) do
            if v:is_suit(card.ability.extra.suit) and v:get_id() == card.ability.extra.id then
                card.joker_display_values.Xmult = card.ability.extra.good_Xmult
                break
            end
        end
        card.joker_display_values.rank = card.ability.extra.rank
        card.joker_display_values.suit = card.ability.extra.suit
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[4] then
            reminder_text.children[4].config.colour = lighten(G.C.SUITS[card.ability.extra.suit], 0.35)
        end
        return false
    end
}

jd_def['j_mxms_gravity'] = { -- Gravity
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "rounds" },
        { text = " levels" }
    },
    text_config = { colour = G.C.ATTENTION, scale = 0.4 }
}

jd_def['j_mxms_group_chat'] = { -- Group Chat
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 }
}

jd_def['j_mxms_hamill'] = { -- Hamill
    text = {
        { ref_table = "card.joker_display_values", ref_value = "hand" }
    },
    text_config = { colour = G.C.ORANGE, scale = 0.4 },
    calc_function = function(card)
        card.joker_display_values.hand = localize(Maximus.get_most_played_hand(), 'poker_hands')
    end
}

jd_def['j_mxms_harmony'] = { -- Harmony
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 },
    calc_function = function(card)
        card.joker_display_values.mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            local ranks = {}

            for i = 1, #scoring_hand do
                local unique = true
                for j = 1, #ranks do
                    if ranks[j] == scoring_hand[i]:get_id() then
                        unique = false
                    end
                end
                if #ranks == 0 or unique then
                    ranks[#ranks + 1] = scoring_hand[i]:get_id()
                end
            end

            if #ranks >= 3 then
                card.joker_display_values.mult = card.ability.extra.mult
            end
        end
    end
}

jd_def['j_mxms_hedonist'] = { -- Hedonist
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_high_dive'] = { -- High Dive
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize('jdis_inactive')
        local text, _, _ = JokerDisplay.evaluate_hand()
        if text == 'High Card' then
            card.joker_display_values.active = localize('jdis_active')
        end
    end
}

jd_def['j_mxms_honorable'] = { -- Honorable Joker
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 }
}

jd_def['j_mxms_hopscotch'] = { -- Hopscotch
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.4 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'hopscotch')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_hugo'] = { -- Hugo
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.4 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'hugo')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_icosahedron'] = { -- Icosahedron
    text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "tally", colour = G.C.BLUE },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "goal" },
        { text = ")" },
    }
}

jd_def['j_mxms_impractical_joker'] = { -- Impractical Joker
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "hand" },
        { text = ")" },
    },
    reminder_config = { colour = G.C.ORANGE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.Xmult = 1
        card.joker_display_values.hand = localize(G.GAME.current_round.mxms_impractical_hand, 'poker_hands')
        if card.ability.extra.fails == 3 then
            card.joker_display_values.Xmult = card.abilit.extra.fail_Xmult
        end
        local text, _, _ = JokerDisplay.evaluate_hand()
        if text == G.GAME.current_round.mxms_impractical_hand then
            card.joker_display_values.Xmult = card.abilit.extra.Xmult
        end
    end
}

jd_def['j_mxms_jackpot'] = { -- Jackpot
    text = {
        { text = "+$",                             colour = G.C.GOLD },
        { ref_table = "card.ability.extra",        ref_value = "money", colour = G.C.GOLD, retrigger_type = "mult" },
        { text = " ", },
        { ref_table = "card.joker_display_values", ref_value = "odds",  colour = G.C.GREEN }
    },
    reminder_text = {
        { text = "(7,7,7)" },
    },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'jackpot')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_jestcoin'] = { -- JestCoin
    text = {
        { text = "+$",                             colour = G.C.GOLD },
        { ref_table = "card.ability.extra",        ref_value = "money", colour = G.C.GOLD, retrigger_type = "mult" },
        { text = " ", },
        { ref_table = "card.joker_display_values", ref_value = "odds",  colour = G.C.GREEN }
    },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'jestcoin')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_joker_plus'] = { -- Joker+
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 }
}

jd_def['j_mxms_kings_rook'] = { -- King's Rook
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(K,5)" },
    },
    reminder_config = { colour = G.C.ORANGE, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.Xmult = 1
        local fives = false
        local kings = false
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if scoring_hand[i]:get_id() == 5 then
                    fives = true
                    count = count + 1
                elseif scoring_hand[i]:get_id() == 13 then
                    kings = true
                    count = count + 1
                end
            end
            card.joker_display_values.Xmult = fives and kings and card.ability.extra.better_xmult or
                (fives or kings) and card.ability.extra.base_xmult or 1
        end
    end
}

jd_def['j_mxms_lazy'] = { -- Lazy Joker
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local chips = 0
        local text, _, _ = JokerDisplay.evaluate_hand()
        if text == card.ability.type then
            chips = card.ability.chips
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.localized_text = localize(card.ability.type, 'poker_hands')
    end
}

jd_def['j_mxms_light_show'] = { -- Light Show
    reminder_text = {
        { text = "(Bonus,Mult)" },
    },
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return (SMODS.has_enhancement(playing_card, 'm_bonus') or
                SMODS.has_enhancement(playing_card, 'm_mult')) and
            joker_card.ability.extra.reps * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}

jd_def['j_mxms_little_brother'] = { -- Little Brother
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "blueprint_compat", colour = G.C.RED },
        { text = ")" },
    },
    calc_function = function(card)
        local copied_joker, copied_debuff = JokerDisplay.calculate_blueprint_copy(card)
        card.joker_display_values.blueprint_compat = localize('k_incompatible')
        JokerDisplay.copy_display(card, copied_joker, copied_debuff)
    end,
    get_blueprint_joker = function(card)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                if i ~= 1 then
                    return G.jokers.cards[i - 1]
                end
                break
            end
        end
        return nil
    end
}

jd_def['j_mxms_loaded_gun'] = { -- Loaded Gun
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(Steel)" },
    },
    reminder_config = { colour = G.C.ORANGE, scale = 0.3 },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if SMODS.has_enhancement(scoring_hand[i], 'm_steel') then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.Xmult = math.max(card.ability.extra.Xmult * count, 1)
    end
}

jd_def['j_mxms_loony'] = { -- Loony Joker
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local mult = 0
        local text, _, _ = JokerDisplay.evaluate_hand()
        if text == card.ability.type then
            mult = card.ability.mult
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = localize(card.ability.type, 'poker_hands')
    end
}

jd_def['j_mxms_lucy'] = { -- Lucy in the Sky
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.4 },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if scoring_hand[i]:is_suit('Diamonds') then
                    count = count + 1
                end
            end
        end
        local numerator, denominator = SMODS.get_probability_vars(card, count, card.ability.extra.odds, 'lucy')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_marco_polo'] = { -- Marco Polo
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 },
    calc_function = function(card)
        card.joker_display_values.mult = card.ability.extra.base_mult + 3 - (#G.jokers.cards * 3) ..
            ' to +' .. card.ability.extra.base_mult
    end
}

jd_def['j_mxms_messiah'] = { -- Messiah
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 }
}

jd_def['j_mxms_minimalist'] = { -- Minimalist
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 },
    calc_function = function(card)
        local chips = card.ability.extra.base_chips
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) and chips > 0 then
                    chips = chips - card.ability.extra.dChips
                end
            end
        end
        card.joker_display_values.chips = chips
    end
}

jd_def['j_mxms_monk'] = { -- Monk
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 }
}

jd_def['j_mxms_nicholson'] = { -- Nicholson
    reminder_text = {
        { text = "(Any Edition)" },
    },
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return playing_card.edition and joker_card.ability.extra.reps * JokerDisplay.calculate_joker_triggers(joker_card) or
            0
    end
}

jd_def['j_mxms_normal'] = { -- James
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +",                             colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if not scoring_hand[i].edition and not scoring_hand[i].seal and not next(SMODS.get_enhancements(scoring_hand[i])) then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.chips = card.ability.extra.chips * count
        card.joker_display_values.mult = card.ability.extra.mult * count
    end
}

jd_def['j_mxms_obelisk'] = { -- Obelisk the Tormentor
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_occam'] = { -- Occam's Razor
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        local count = 0
        local text, _, _ = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            count = #G.hand.highlighted
        end
        card.joker_display_values.Xmult = G.hand.config.highlighted_limit - count + 1
    end
}

jd_def['j_mxms_old_man_jimbo'] = { -- Old Man Jimbo
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = 1 + (card.ability.extra.gain * G.GAME.current_round.hands_left)
    end
}

jd_def['j_mxms_paperclip'] = { -- Red Paperclip
    reminder_text = {
        { text = "(" },
        { text = "$",         colour = G.C.GOLD },
        { ref_table = "card", ref_value = "sell_cost", colour = G.C.GOLD },
        { text = ")" },
    },
    reminder_text_config = { scale = 0.35 }
}

jd_def['j_mxms_pessimistic'] = { -- Pessimistic Joker
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 }
}

jd_def['j_mxms_piggy_bank'] = { -- Piggy Bank
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 },
    calc_function = function(card)
        card.joker_display_values.chips = card.ability.extra.dollars_stored * card.ability.extra.chip_factor
    end
}

jd_def['j_mxms_poindexter'] = { -- Poindexter
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_prince'] = { -- The Prince
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(Polychrome,Face)" },
    },
    reminder_config = { colour = G.C.ORANGE, scale = 0.3 },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for i = 1, #scoring_hand do
                if scoring_hand[i].edition and scoring_hand[i].edition.polychrome and scoring_hand[i]:is_face() then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.Xmult = math.max(card.ability.extra.Xmult * count, 1)
    end
}

jd_def['j_mxms_ra'] = { -- Winged Dragon of Ra
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_romero'] = { -- Romero
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_salt_circle'] = { -- Salt Circle
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 },
    calc_function = function(card)
        card.joker_display_values.chips = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral and
            G.GAME.consumeable_usage_total.spectral * card.ability.extra.gain or 0
    end
}

jd_def['j_mxms_sisillyan'] = { -- Sisillyan
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult" }
            }
        }
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'sisilly')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_sisyphus'] = { -- Sisyphus
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}

jd_def['j_mxms_slifer'] = { -- Slifer the Sky Dragon
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = #G.hand.cards > 0 and #G.hand.cards - #G.hand.highlighted or 1
    end
}

jd_def['j_mxms_slippery_slope'] = { -- Slippery Slope
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +",                             colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
    },
    calc_function = function(card)
        local chips = 0
        local mult = 0
        local text, poker_hands, _ = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for k, v in pairs(poker_hands) do
                if k ~= text and SMODS.PokerHands[k] and next(v) then
                    chips = chips + SMODS.PokerHands[k].chips
                    mult = mult + SMODS.PokerHands[k].mult
                end
            end
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.mult = mult
    end
}

jd_def['j_mxms_smoker'] = { -- Smoker
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 },
    calc_function = function(card)
        card.joker_display_values.chips = card.ability.extra.chips
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text == 'High Card' then
            local chips = 0
            for k, v in pairs(scoring_hand) do
                chips = chips + v:get_chip_bonus() * G.GAME.mxms_soil_mod
            end
            card.joker_display_values.chips = card.ability.extra.chips + chips
        end
    end
}

jd_def['j_mxms_sneaky_spirit'] = { -- Sneaky Spirit
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "discards",    colour = G.C.RED },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "discard_goal" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = 0
        if card.ability.extra.discards == card.ability.extra.discard_goal then
            card.joker_display_values.Xmult = card.ability.extra.Xmult
        end
    end
}

jd_def['j_mxms_soyjoke'] = { -- Soyjoke
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = G.GAME.mxms_soy_mod * card.ability.extra.gain + 1
    end
}

jd_def['j_mxms_spare_tire'] = { -- Spare Tire
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.4 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.prob, card.ability.extra.odds,
            'tire')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def['j_mxms_stone_thrower'] = { -- Stone Thrower
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS, scale = 0.4 }
}

jd_def['j_mxms_streaker'] = { -- Streaker
    text = {
        { text = "+",                       colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +",                      colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
    }
}

jd_def['j_mxms_tofu'] = { -- Tofu
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "blueprint_compat", colour = G.C.RED },
        { text = ")" },
    },
    calc_function = function(card)
        local copied_joker, copied_debuff = JokerDisplay.calculate_blueprint_copy(card)
        card.joker_display_values.blueprint_compat = localize('k_incompatible')
        JokerDisplay.copy_display(card, copied_joker, copied_debuff)
    end,
    get_blueprint_joker = function(card)
        return G.jokers.cards[#G.jokers.cards]
    end
}

jd_def['j_mxms_unpleasant_gradient'] = { -- Unpleasant Gradient
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = localize('jdis_inactive')
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            card.joker_display_values.active = #scoring_hand == 4 and localize('jdis_active') or
                localize('jdis_inactive')
        end
    end
}

jd_def['j_mxms_vinyl_record'] = { -- Vinyl Record
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "value" },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "hands",     colour = G.C.BLUE },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "hand_limit" },
        { text = ")" },
    },
    calc_function = function(card)
        if card.ability.extra.side == 'a_side' then
            card.joker_display_values.value = card.ability.extra.mult
            return
        else
            card.joker_display_values.value = card.ability.extra.chips
            return
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        if card.ability.extra.side == 'a_side' and text.children[1] and text.children[2] then
            text.children[1].config.colour = lighten(G.C.MULT, 0.35)
            text.children[2].config.colour = lighten(G.C.MULT, 0.35)
            return
        elseif card.ability.extra.side == 'b_side' and text.children[1] and text.children[2] then
            text.children[1].config.colour = lighten(G.C.CHIPS, 0.35)
            text.children[2].config.colour = lighten(G.C.CHIPS, 0.35)
            return
        end
    end
}

jd_def['j_mxms_werewolf'] = { -- Werewolf
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT, scale = 0.4 }
}

jd_def['j_mxms_wild_buddy'] = { -- Wild Buddy
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.Xmult = card.ability.extra.Xmult
        card.joker_display_values.active = localize('jdis_active')
        if G.GAME.blind.boss then
            card.joker_display_values.Xmult = 1
            card.joker_display_values.active = localize('jdis_inactive')
        end
    end
}

jd_def['j_mxms_zombie'] = { -- Zombie
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "copied_card", colour = G.C.RED },
        { text = ")" },
    },
    calc_function = function(card)
        local copied_joker, copied_debuff = JokerDisplay.calculate_blueprint_copy(card)
        card.joker_display_values.copied_card = localize('k_none')
        JokerDisplay.copy_display(card, copied_joker, copied_debuff)
    end,
    get_blueprint_joker = function(card)
        if G.GAME.current_round.mxms_zombie_target.card ~= nil then
            return G.GAME.current_round.mxms_zombie_target.card
        end
        return nil
    end
}

if Maximus_config.horoscopes then
    local jd_get_display_areas_ref = JokerDisplay.get_display_areas
    function JokerDisplay.get_display_areas()
        local ret = jd_get_display_areas_ref()
        if G.mxms_horoscope then
            table.insert(ret, G.mxms_horoscope)
        end
        return ret
    end

    jd_def['j_mxms_employee'] = { -- Employee
        text = {
            { text = "+$" },
            { ref_table = "card.joker_display_values", ref_value = "dollars" },
        },
        text_config = { colour = G.C.GOLD, scale = 0.4 },
        calc_function = function(card)
            card.joker_display_values.dollars = #G.mxms_horoscope.cards * card.ability.extra.dollars
        end
    }

    jd_def['j_mxms_hippie'] = { -- Hippie
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
                }
            }
        },
    }

    jd_def['c_mxms_aquarius'] = { -- Aquarius
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "tally", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "goal" },
            { text = ")" },
        },
    }

    jd_def['c_mxms_capricorn'] = { -- Capricorn
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "tally", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "goal" },
            { text = ")" },
        },
    }

    jd_def['c_mxms_gemini'] = { -- Gemini
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "times", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "goal" },
            { text = ")" },
        },
    }

    jd_def['c_mxms_libra'] = { -- Libra
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "money_spent", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "goal" },
            { text = ")" },
        },
    }

    jd_def['c_mxms_ophiucus'] = { -- Ophiucus
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra",        ref_value = "handtypes_played", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.joker_display_values", ref_value = "goal" },
            { text = ")" },
        },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "antes" },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "ante_limit" },
            { text = ")" },
        },
        calc_function = function(card)
            card.joker_display_values.goal = #card.ability.hands
        end

    }

    jd_def['c_mxms_pisces'] = { -- Pisces
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "tally", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "goal" },
            { text = ")" },
        },
    }

    jd_def['c_mxms_scorpio'] = { -- Scorpio
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "hands", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "goal" },
            { text = ")" },
        },
    }

    jd_def['c_mxms_taurus'] = { -- Taurus
        text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "times", colour = Maximus.C.HOROSCOPE },
            { text = "/" },
            { ref_table = "card.ability.extra", ref_value = "goal" },
            { text = ")" },
        },
    }
end
