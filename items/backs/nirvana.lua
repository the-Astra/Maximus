SMODS.Back {
    key = 'nirvana',
    loc_txt = {
        name = 'Nirvana Deck',
        text = { 
            'Rerolls start at {C:money}$0{}', 
            'Shop items cost {X:mult,C:white}X1.5{} as much' 
        }
    },
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
