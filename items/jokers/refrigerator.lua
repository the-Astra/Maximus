SMODS.Joker { -- Refrigerator
    key = 'refrigerator',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 2
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.mod_probability and Maximus.is_food(context.trigger_obj) then
            if context.trigger_obj.config.center.key == 'j_mxms_fortune_cookie' then
                return {
                    numerator = context.numerator
                }
            end
            return {
                denominator = context.denominator
            }
        end
    end,
    calc_scaling = function(self, card, other_card, scaling, scalar, args)
        if args.operation == '-' and Maximus.is_food(other_card) then
            return {
                message = localize('k_mxms_preserved_ex'),
                scaling_value = scaling + (scalar * 0.5),
                scaling_message = tostring(scalar * 0.5)
            }
        end
    end
}
