SMODS.Joker {
    key = 'change',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 16
    },
    rarity = 2,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 5,
    mxms_modify_final_cashout = function(self, card, dollars)
        local dollar_remainder = dollars % to_big(10)
        if dollar_remainder ~= to_big(0) then
            return 10 - dollar_remainder
        end
    end
}
