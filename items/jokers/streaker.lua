SMODS.Joker {
    key = 'streaker',
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
            mult = 0,
            chip_gain = 20,
            mult_gain = 5
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.streak, stg.hands, stg.chips, stg.mult, stg.chip_gain, stg.mult_gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.streak > 0 then
            return {
                mult_mod = stg.mult,
                chip_mod = stg.chips,
                message = localize('k_mxms_streaked_ex'),
                colour = G.C.MULT
            }
        end

        if context.before and not context.blueprint then
            stg.hands = stg.hands + 1
            if stg.hands > 1 and stg.streak ~= 0 then
                stg.streak = 0
                stg.chips = 0
                stg.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if stg.hands == 1 then
                stg.hands = 0
                stg.streak = stg.streak + 1
                
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "chips",
                    scalar_value = "chip_gain",
                    no_message = true
                })

                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "mult",
                    scalar_value = "mult_gain",
                    no_message = true
                })

                return {
                    message = localize('k_mxms_streak') .. ' ' .. stg.streak,
                    colour = G.C.ATTENTION
                }
            else
                stg.hands = 0
            end
        end
    end
}
