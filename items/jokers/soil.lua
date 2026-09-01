SMODS.Joker {
    key = 'soil',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 6
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 3,
    attributes = {
        'passive',
        'mod_scaling'
    },
    blueprint_compat = false,
    cost = 8,
    calculate = function(self, card, context)
        local stg = card.ability.extra
    
        
        if context.scaling_card and (context.operation == '+' or context.operation == 'X') then
            return {
                message = localize('k_mxms_doubled_ex'),
                override_scalar= context.scalar * 2
            }
        end
    end
}
