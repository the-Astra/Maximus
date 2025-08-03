CardSleeves.Sleeve {
    key = "nirvana",
    atlas = "Sleeves",
    pos = {
        x = 1,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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
        if self.get_current_deck_key() == 'b_mxms_nirvana' then
            -- If on Nirvana deck, give 2 extra free rerolls
            SMODS.change_free_rerolls(2)
            calculate_reroll_cost(true)
        else
            --Change shop prices
            G.GAME.mxms_shop_price_multiplier = 1.5

            -- Change reroll starting price
            G.GAME.starting_params.reroll_cost = 0
        end
    end
}
