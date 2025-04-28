SMODS.Joker {
    key = 'soil',
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
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
