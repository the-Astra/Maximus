SMODS.Back {
    key = 'nirvana',
    atlas = 'Backs',
    pos = {
        x = 1,
        y = 0
    },
    apply = function(self, back)
        --Change shop prices
        G.GAME.shop_price_multiplier = 1.5

        -- Change reroll starting price
        G.GAME.starting_params.reroll_cost = 0
    end
}
