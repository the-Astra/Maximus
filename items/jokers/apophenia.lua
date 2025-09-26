SMODS.Joker {
    key = 'apophenia',
    atlas = 'Placeholder',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 5,
    mxms_credits = {
        art = { "???" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and next(context.poker_hands["Straight"]) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({set='Conspiracy', edition = 'e_negative'})
                    card:juice_up()
                    return true;
                end
            }))
        end
    end
}
