SMODS.Back {
    key = 'empire',
    atlas = 'Modifiers',
    pos = {
        x = 0,
        y = 1
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    apply = function(self, back)
        --Deck modifier
        G.GAME.modifiers.mxms_empire_arcana = true
    end,
    calculate = function(self, back, context)
        if context.mxms_pre_choice_modify and context.booster.kind == 'Arcana' then
            local pool = get_current_pool('Tarot')
            for n, v in ipairs(pool) do
                if v == 'UNAVAILABLE' then
                    table.remove(pool, n)
                end
            end
            context.card.ability.extra = #pool - context.card.ability.extra
        end
    end,
}
