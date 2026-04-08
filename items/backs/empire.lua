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
    calculate = function(self, back, context)
        if context.mxms_pre_choice_modify and context.booster.kind == 'Arcana' then
            context.card.ability.extra = SMODS.size_of_pool(get_current_pool('Tarot'))
        end

        if context.create_booster_card and context.booster.config.center.kind == 'Arcana' then
            local pool = SMODS.get_clean_pool('Tarot')

            return {
                booster_create_flags = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key = pool[context.index],
                    key_append =
                    'ar1'
                }
            }
        end
    end,
}
