SMODS.Booster {
    key = "horoscope_normal_1",
    kind = "Horoscope",
    atlas = "Boosters",
    loc_txt = {
        name = 'Zodiac Pack',
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:horoscope} Horoscope{} cards to",
            "be used immediately",
        },
        group_name = 'Zodiac Pack'
    },
    pos = {
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
