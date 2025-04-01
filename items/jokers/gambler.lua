SMODS.Joker {
    key = 'gambler',
    loc_txt = {
        name = 'Gambler',
        text = { 
            'Capped sources of money generation', 
            'have their limits {C:attention}doubled{}' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 3
    },
    rarity = 1,
    config = {},
    blueprint_compat = false,
    cost = 7,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.gambler_mod = G.GAME.gambler_mod * 2
        G.GAME.interest_cap = G.GAME.interest_cap * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.gambler_mod = G.GAME.gambler_mod / 2
        G.GAME.interest_cap = G.GAME.interest_cap / 2
    end
}
