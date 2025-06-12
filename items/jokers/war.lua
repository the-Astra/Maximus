SMODS.Joker {
    key = 'war',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 0
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 8,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.mxms_war_mod = G.GAME.mxms_war_mod * 2
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.mxms_war_mod = G.GAME.mxms_war_mod / 2
    end
}
