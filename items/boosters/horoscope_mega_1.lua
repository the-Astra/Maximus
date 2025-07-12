SMODS.Booster {
    key = "horoscope_mega_1",
    kind = "Horoscope",
    atlas = "Boosters",
    group_key = "k_mxms_zodiac_pack",
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = 4,
        choose = 2
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "N/A"
    },
    cost = 8,
    weight = 0.12,
    select_card = 'mxms_horoscope',
    create_card = function(self, card)
        return create_card("Horoscope", G.pack_cards, nil, nil, true, true, nil, "mxms_zodiac")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, Maximus.C.SET.Horoscope)
        ease_background_colour({ new_colour = Maximus.C.SET.Horoscope, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose + (G.GAME.mxms_choose_mod or 0), card.ability.extra } }
    end,
    in_pool = function(self, args)
        if G.mxms_horoscope.config.highlighted_limit > 1 then
            return true
        end

        return false
    end
}
