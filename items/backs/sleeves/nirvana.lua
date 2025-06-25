CardSleeves.Sleeve {
    key = "nirvana",
    atlas = "Sleeves",
    pos = {
        x = 0,
        y = 0
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_nirvana' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end,
    apply = function(self, sleeve)
        --Change shop prices
        G.GAME.mxms_shop_price_multiplier = 1.5

        -- Change reroll starting price
        G.GAME.starting_params.reroll_cost = 0

        -- If on Nirvana deck, give 2 extra free rerolls
        if self.get_current_deck_key() == 'b_mxms_nirvana' then
            SMODS.change_free_rerolls(2)
            calculate_reroll_cost(true)
        end
    end
}