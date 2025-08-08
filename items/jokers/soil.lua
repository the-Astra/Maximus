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
    blueprint_compat = false,
    cost = 8,
    calc_scaling = function(self, card, other_card, scaling, scalar, args)
        local stg = card.ability.extra
        if args.operation == '+' then
            return {
                scalar = scalar * 2
            }
        end
    end
}
