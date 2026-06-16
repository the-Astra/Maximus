Maximus.ClassifiedBooster = SMODS.Booster:extend {
    kind = "Conspiracy",
    group_key = "k_mxms_classified_pack",
    atlas = 'mxms_Classified',
    mxms_credits = {
        art = { "squeax09" },
        code = { "theAstra" }
    },
    disable_shine = true,
    draw_cards = true,
    create_card = function(self, card)
        return create_card("Conspiracy", G.pack_cards, nil, nil, true, true, nil, "cspy_classified")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Tarot)
        ease_background_colour({ new_colour = G.C.SET.Tarot, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}

Maximus.ClassifiedBooster {
    key = "classified_jumbo_1",
    pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = 4,
        choose = 1
    },
    cost = 6,
    weight = 0.48
}

Maximus.ClassifiedBooster {
    key = "classified_mega_1",
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = 4,
        choose = 2
    },
    cost = 8,
    weight = 0.12
}

Maximus.ClassifiedBooster {
    key = "classified_normal_1",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 4,
    weight = 0.96
}

Maximus.ClassifiedBooster {
    key = "classified_normal_2",
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 4,
    weight = 0.96
}
