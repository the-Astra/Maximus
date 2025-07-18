SMODS.Joker { -- Refrigerator
    key = 'refrigerator',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 2
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.mod_probability and mxms_is_food(context.trigger_obj) then
            if context.trigger_obj.config.center.key == 'j_mxms_fortune_cookie' then
                return {
                    numerator = context.numerator
                }
            end
            return {
                denominator = context.denominator
            }
        end
    end
}
