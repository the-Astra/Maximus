SMODS.Joker {
    key = 'war',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 8,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.war_mod = G.GAME.war_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.war_mod = G.GAME.war_mod / 2
    end
}
