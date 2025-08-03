SMODS.Joker {
    key = 'soil',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 6
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.mxms_soil_mod = G.GAME.mxms_soil_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.mxms_soil_mod = G.GAME.mxms_soil_mod / 2
    end
}
