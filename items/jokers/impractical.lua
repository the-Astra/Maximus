SMODS.Joker {
    key = 'impractical_joker',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 3,
            fail_Xmult = 0.5,
            fails = 0
        }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.fails, stg.Xmult, stg.fail_Xmult, G.localization.misc.poker_hands[G.GAME.current_round.impractical_hand] }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            -- If correct hand is played
            if context.scoring_name == G.GAME.current_round.impractical_hand then
                if not context.blueprint then
                    stg.fails = 0
                end

                return {
                    x_mult = stg.Xmult,
                }

                -- If incorrect hand is played
            else
                if not context.blueprint then
                    stg.fails = stg.fails + 1
                end

                -- If below 3 fails
                if stg.fails < 3 then
                    return {
                        message = localize('k_mxms_fail') .. ' ' .. stg.fails,
                        colour = G.C.RED,
                        card = card
                    }

                    -- If 3 fails
                elseif stg.fails == 3 then
                    return {
                        message = 'Tonight\'s Biggest Loser',
                        Xmult_mod = stg.fail_Xmult,
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            stg.fails = 0
            return {
                message = localize('k_reset'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
