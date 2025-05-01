SMODS.Joker {
    key = 'gambler',
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
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
