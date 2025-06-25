CardSleeves.Sleeve {
    key = "professional",
    atlas = "Sleeves",
    pos = {
        x = 0,
        y = 0
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_professional' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key, vars = {colours = {G.C.HAND_LEVELS[2]}} }
    end,
    apply = function(self, sleeve)
        --Disable skipping
        G.GAME.modifiers.disable_blind_skips = true

        -- Change blind size
        G.GAME.starting_params.ante_scaling = 1.25

        if self.get_current_deck_key() == 'b_mxms_professional' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in pairs(G.GAME.hands) do
                        level_up_hand(self, k, true)
                    end
                    return true;
                end
            }))
        end
    end
}
