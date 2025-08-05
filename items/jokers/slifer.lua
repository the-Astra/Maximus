SMODS.Joker {
    key = 'slifer',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 10
    },
    rarity = 3,
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and #G.hand.cards > 0 then
            return {
                x_mult = #G.hand.cards > 0 and #G.hand.cards or 1
            }
        end
    end
}
