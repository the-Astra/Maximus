SMODS.Joker {
    key = 'boar_bank',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 17
    },
    rarity = 1,
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 5,
    mxms_modify_final_cashout = function(self, card, dollars)
        local half = dollars/2
        card.ability.extra_value  = card.ability.extra_value + half
        card:set_cost()
        SMODS.calculate_effect({message = localize('k_mxms_halved'), colour = G.C.RED, sound = 'slice1'}, card)
        return -half
    end
}
