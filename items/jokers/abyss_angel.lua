SMODS.Joker {
    key = 'abyss_angel',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 13
    },
    rarity = 2,
    config = {
        extra = {
            gain = 0.25,
            target_chips = 200,
            accrued_chips = 0,
            Xmult = 1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.target_chips, stg.accrued_chips, stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.individual and context.cardarea == G.play and not context.blueprint then
            stg.accrued_chips = stg.accrued_chips + context.other_card:get_chip_bonus()
            return {
                message = stg.accrued_chips .. '/' .. stg.target_chips,
                colour = G.C.CHIPS,
                message_card = card,
                func = function()
                    if stg.accrued_chips >= stg.target_chips then
                        stg.accrued_chips = stg.accrued_chips - stg.target_chips
                        SMODS.scale_card(card,{
                            ref_table = stg,
                            ref_value = "Xmult",
                            scalar_value = "gain",
                            message_colour = G.C.ATTENTION
                        })
                    end
                end
            }
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
