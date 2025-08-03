SMODS.Back {
    key = 'nirvana',
    atlas = 'Modifiers',
    pos = {
        x = 1,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    apply = function(self, back)
        --Change shop prices
        G.GAME.mxms_shop_price_multiplier = 1.5

        -- Change reroll starting price
        G.GAME.starting_params.reroll_cost = 0
    end
}
