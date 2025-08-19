SMODS.Joker {
    key = 'gambler',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 3
    },
    rarity = 1,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 7,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.mxms_gambler_mod = G.GAME.mxms_gambler_mod * 2
        G.GAME.interest_cap = G.GAME.interest_cap * 2
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.mxms_gambler_mod = G.GAME.mxms_gambler_mod / 2
        G.GAME.interest_cap = G.GAME.interest_cap / 2
    end
}

SMODS.JimboQuip {
    key = 'lq_gambler',
    type = 'loss',
    extra = { center = 'j_mxms_gambler' }
}

SMODS.JimboQuip {
    key = 'wq_gambler',
    type = 'win',
    extra = {
        center = 'j_mxms_gambler',
        times = 2
    }
}
