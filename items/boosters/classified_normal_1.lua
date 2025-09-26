SMODS.Booster {
    key = "classified_normal_1",
    kind = "Conspiracy",
    group_key = "k_cspy_classified_pack",
    atlas = 'Booster',
    post = {
        x = 0,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 4,
    weight = 0.96,
    create_card = function(self, card)
        return create_card("Conspiracy", G.pack_cards, nil, nil, true, true, nil, "cspy_classified")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Tarot)
        ease_background_colour({ new_colour = G.C.SET.Tarot, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose, card.ability.extra } }
    end
}
