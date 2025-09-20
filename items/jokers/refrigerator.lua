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
        if context.mod_probability and context.trigger_obj.config and context.trigger_obj.config.center and context.trigger_obj.config.pools.Food then
            if context.trigger_obj.config.center_key == 'j_mxms_fortune_cookie' then
                return {
                    numerator = context.numerator
                }
            end
            return {
                denominator = context.denominator
            }
        end
    end,
    calc_scaling = function(self, card, other_card, initial, scalar_value, args)
        if args.operation == '-' and Maximus.is_food(other_card) then
            return {
                override_scalar_value = {
                    value = scalar_value * 0.5
                },
                message = localize('k_mxms_preserved_ex'),
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_refrigerator',
    type = 'loss',
    extra = { center = 'j_mxms_refrigerator' }
}
