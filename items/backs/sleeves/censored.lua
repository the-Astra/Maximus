CardSleeves.Sleeve {
    key = "censored",
    atlas = "Sleeves",
    pos = {
        x = 0,
        y = 0
    },
    mxms_credits = {
        art = { "???" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_censored' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end,
    calculate = function(self, sleeve, context)
        if self.get_current_deck_key() == 'b_mxms_censored' then
            if context.fix_probability and context.trigger_obj and context.trigger_obj.ability and context.trigger_obj.ability.set == 'Conspiracy' then
                return {
                    denominator = 3
                }
            end
        end
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == 'b_mxms_destiny' then

        else
            G.GAME.modifiers.mxms_horoscope_ante_end = 'p_mxms_classified_mega_1'
        end
    end
}
