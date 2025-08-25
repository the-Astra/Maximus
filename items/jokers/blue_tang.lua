SMODS.Joker {
    key = 'blue_tang',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    calculate = function(self, card, context)
        if context.prevent_tag_trigger and
            (context.other_context.type == 'store_joker_create' or
                context.other_context.type == 'store_joker_modify') and
            card ~= G.jokers.cards[#G.jokers.cards] then
            return {
                prevent_trigger = true
            }
        end
    end,
}
