Maximus.ZodiacBooster = SMODS.Booster:extend {
    kind = "Horoscope",
    atlas = "mxms_Zodiac",
    group_key = "k_mxms_zodiac_pack",
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        music = { "BitterDoes" }
    },
    attributes = {
        'horoscope'
    },
    select_card = 'mxms_horoscope',
    create_card = function(self, card)
        return create_card("Horoscope", G.pack_cards, nil, nil, true, true, nil, "mxms_zodiac")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, Maximus.C.SET.Horoscope)
        ease_background_colour({ new_colour = Maximus.C.HOROSCOPE_BG, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('e86fa5'), HEX('cbf5f1') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
}

Maximus.ZodiacBooster {
    key = "horoscope_jumbo_1",
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
    in_pool = function(self, args)
        return Maximus_config.horoscopes
    end
}

Maximus.ZodiacBooster {
    key = "horoscope_mega_1",
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = 4,
        choose = 2
    },
    cost = 8,
    weight = 0.12,
    in_pool = function(self, args)
        if G.mxms_horoscope and G.mxms_horoscope.config.highlighted_limit > 1 and Maximus_config.horoscopes then
            return true
        end

        return false
    end
}

Maximus.ZodiacBooster {
    key = "horoscope_normal_1",
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
    in_pool = function(self, args)
        return Maximus_config.horoscopes
    end
}

Maximus.ZodiacBooster {
    key = "horoscope_normal_2",
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 4,
    weight = 0.96,
    in_pool = function(self, args)
        return Maximus_config.horoscopes
    end
}
