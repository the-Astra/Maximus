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
            gain = 0.5,
            target_chips = 200,
            accrued_chips = 0,
            Xmult = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "theAstra"
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
                        stg.Xmult = stg.Xmult + stg.gain * G.GAME.soil_mod
                        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.attention }, card)
                        SMODS.calculate_context({ scaling_card = true })
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
