SMODS.Joker {
    key = 'change',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 16
    },
    rarity = 2,
    attributes = {
        'economy'
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.modify_final_cashout then
            local dollar_remainder = context.amount % to_big(10)
            if dollar_remainder ~= to_big(0) then
                return {
                    modify = 10 - dollar_remainder
                }
            end
        end
    end
}
