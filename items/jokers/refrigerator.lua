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
    attributes = {
        'mod_chance',
        'mod_scaling',
        'passive'
    },
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.mod_probability and context.trigger_obj and context.trigger_obj:has_attribute('food') then
            if context.trigger_obj.config.center_key == 'j_mxms_fortune_cookie' then
                return {
                    numerator = context.numerator
                }
            end
            return {
                denominator = context.denominator
            }
        end

        if context.scaling_card and context.operation == '-' and context.card:has_attribute('food') then
            return {
                override_scalar = context.scalar * 0.5,
                message = localize('k_mxms_preserved_ex')
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_refrigerator',
    type = 'loss',
    extra = { center = 'j_mxms_refrigerator' }
}
