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
            context.card.ability.extra = SMODS.size_of_pool(pool)
        end
    end,
}
