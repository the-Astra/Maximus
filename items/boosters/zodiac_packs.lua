SMODS.Atlas { -- Zodiac Boosters Atlas
    key = 'Zodiac',
    path = "Zodiac.png",
    px = 71,
    py = 95
}

Maximus.ZodiacBooster = SMODS.Booster:extend {
    kind = "Horoscope",
    atlas = "mxms_Zodiac",
    group_key = "k_mxms_zodiac_pack",
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" }
    },
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
