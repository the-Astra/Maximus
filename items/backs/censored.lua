SMODS.Back {
    key = 'censored',
    atlas = 'Placeholder',
    pos = {
        x = 4,
        y = 2
    },
    mxms_credits = {
        art = { "???" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    calculate = function(self, back, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.game_over then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({set='Conspiracy'})
                    return true;
                end
            }))
        end
    end,
}
