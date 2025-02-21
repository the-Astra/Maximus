SMODS.Joker { -- Refrigerator
    key = 'refrigerator',
    loc_txt = {
        name = 'Refrigerator',
        text = { '{C:attention}Food{} Jokers degrade', 'half as fast' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 2
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.fridge_mod = G.GAME.fridge_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.fridge_mod = G.GAME.fridge_mod / 2
    end
}