SMODS.Joker {
    key = 'boar_bank',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 17
    },
    rarity = 1,
    attributes = {
        'economy',
        'sell_value'
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.modify_final_cashout then
            local half = context.amount / 2
            card.ability.extra_value = card.ability.extra_value + math.floor(half)
            card:set_cost()
            return {
                modify = -math.floor(half),
                message = localize('k_mxms_halved'),
                colour = G.C.RED,
                sound = 'slice1'
            }
        end
    end
}
