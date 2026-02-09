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
        else
            if context.end_of_round and not context.individual and not context.repetition and not context.game_over then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({ set = 'Conspiracy' })
                        return true;
                    end
                }))
            end
        end
    end,
}
