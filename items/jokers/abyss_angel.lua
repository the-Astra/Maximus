SMODS.Joker {
    key = 'abyss_angel',
    loc_txt = {
        name = 'Abyss Angel',
        text = {
            'Gains {X:mult,C:white}X#1#{} Mult for every',
            '{C:chips}#2#{} Chips scored',
            'from playing cards',
            '{C:inactive}(Currently: {C:chips}#3#{C:inactive}/#2# Chips,',
            '{X:mult,C:white}X#4#{C:inactive} Mult)'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            gain = 1,
            target_chips = 200,
            accrued_chips = 0,
            Xmult = 1
        }
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
                        stg.Xmult = stg.Xmult + stg.gain
                        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.attention }, card)
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
