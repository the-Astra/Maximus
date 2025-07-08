CardSleeves.Sleeve {
    key = "nuclear",
    atlas = "Sleeves",
    pos = {
        x = 2,
        y = 0
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_nuclear' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == 'b_mxms_nuclear' then
            --If on Nuclear Deck, add an extra joker slot
            G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 1
        else
            --Change blind scaling
            G.GAME.modifiers.mxms_nuclear_size = true
            --Change joker slots
            G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - 4
        end
    end
}
