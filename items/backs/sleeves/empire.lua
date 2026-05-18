CardSleeves.Sleeve {
    key = "empire",
    atlas = "Sleeves",
    pos = {
        x = 3,
        y = 1
    },
    mxms_credits = {
        art = { "squeax09" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_empire' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end,
    calculate = function(self, back, context)
        if self.get_current_deck_key() == 'b_mxms_empire' then
            if context.mxms_pre_choice_modify and context.booster.kind == 'Arcana' then
                context.card.ability.choose = context.card.ability.choose + 1
            end
        else
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
        end
    end,
}