SMODS.Booster {
    key = "horoscope_jumbo_1",
    kind = "Horoscope",
    atlas = "Boosters",
    loc_txt = {
        name = 'Jumbo Zodiac Pack',
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:horoscope} Horoscope{} cards to",
            "be used immediately",
        },
        group_name = 'Zodiac Pack'
    },
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 4,
        choose = 1
    },
    cost = 6,
    weight = 0.48,
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
