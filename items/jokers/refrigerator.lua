SMODS.Joker { -- Refrigerator
    key = 'refrigerator',
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
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
