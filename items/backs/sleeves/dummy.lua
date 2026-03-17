CardSleeves.Sleeve {
    key = "dummy",
    atlas = "Sleeves",
    pos = {
        x = 2,
        y = 1
    },
    mxms_credits = {
        art = { "theAstra" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_dummy' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end
}