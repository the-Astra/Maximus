SMODS.Joker {
    key = 'war',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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

SMODS.JimboQuip {
    key = 'lq_war',
    type = 'loss',
    extra = { center = 'j_mxms_war' }
}
