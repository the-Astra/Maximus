SMODS.Booster {
    key = "horoscope_normal_2",
    kind = "Horoscope",
    atlas = "Boosters",
    group_key = "k_mxms_zodiac_pack",
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "N/A"
    },
    cost = 4,
    weight = 0.96,
    create_card = function(self, card)
        return create_card("Horoscope", G.pack_cards, nil, nil, true, true, nil, "mxms_zodiac")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Horoscope)
        ease_background_colour({ new_colour = G.C.SET.Horoscope, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose + G.GAME.choose_mod, card.ability.extra } }
    end
}
