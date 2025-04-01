SMODS.Joker {
    key = 'soil',
    loc_txt = {
        name = 'Soil Joker',
        text = { 
            'Scaling Jokers gain', 
            '{C:attention}twice{} as much scaling value' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 6
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.soil_mod = G.GAME.soil_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.soil_mod = G.GAME.soil_mod / 2
    end
}
