SMODS.Joker {
    key = 'conveyor_belt',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 12
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0,
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and to_big(stg.chips) > to_big(0) and to_big(stg.mult) > to_big(0) then
            SMODS.calculate_effect({ chips = stg.chips }, card)
            SMODS.calculate_effect({ mult = stg.mult }, card)
        end

        if context.after and not context.blueprint then
            stg.chips = mod_chips(hand_chips * 0.15)
            stg.mult = mod_mult(mult * 0.15)
            return {
                message = localize('k_mxms_pushed_ex'),
                colour = G.C.ATTENTION
            }
        end
    end
}
