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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" }
    },
    cost = 4,
    weight = 0.96,
    select_card = 'mxms_horoscope',
    create_card = function(self, card)
        return create_card("Horoscope", G.pack_cards, nil, nil, true, true, nil, "mxms_zodiac")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, Maximus.C.SET.Horoscope)
        ease_background_colour({ new_colour = Maximus.C.SET.Horoscope, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}
