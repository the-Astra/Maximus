--#region Colors --------------------------------------------------------------------------------------------

Maximus.C = {
    MXMS_PRIMARY = HEX('7855fc'),
    MXMS_SECONDARY = HEX('901b7f'),
    HOROSCOPE = HEX('e86fa5'),
    CONSPIRACY = HEX('7d8c8f'),
    SET = {
        Horoscope = HEX('d9629c'),
        Conspiracy = HEX('fbf5ee')
    },
    SECONDARY_SET = {
        Horoscope = HEX('a64d79'),
        Conspiracy = HEX('7d8c8f')
    }
}

--#endregion

--#region Misc Atlases --------------------------------------------------------------------------------------

SMODS.Atlas { -- Placeholder Atlas
    key = 'Placeholder',
    path = "placeholders.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Modifiers/Backs Atlas
    key = 'Modifiers',
    path = "Modifiers.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Mod Icon
    key = "modicon",
    path = "modicon.png",
    px = 32,
    py = 32
}

SMODS.Atlas { -- Maximus Menu Logo
    key = 'logo',
    path = 'Maximus_Logo.png',
    px = 173,
    py = 61
}

if next(SMODS.find_mod("AntePreview")) then -- Ante Preview compat
    SMODS.Atlas {
        key = 'poker_hands',
        path = "Poker Hands.png",
        px = 53,
        py = 13
    }
end

if CardSleeves then
    SMODS.Atlas { -- Main Sleeve Atlas
        key = 'Sleeves',
        path = "Sleeves.png",
        px = 73,
        py = 95
    }
end

SMODS.Atlas { -- Main Blind Atlas
    key = 'Blinds',
    path = "Blinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

SMODS.Atlas { -- Classified Boosters Atlas
    key = 'Classified',
    path = "Classified.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Zodiac Boosters Atlas
    key = 'Zodiac',
    path = "Zodiac.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Consumable Atlas
    key = 'Consumables',
    path = "Consumables.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Conspiracy Atlas
    key = 'Conspiracy',
    path = "Conspiracy.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Joker Atlas
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- 4D Joker Atlases
    key = '4D',
    path = "4d_joker.png",
    px = 71,
    py = 95,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 71,
    fps = 20
}

SMODS.Atlas {
    key = '4D_soul',
    path = "4d_joker.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Tag Atlas
    key = "Tags",
    path = "Tags.png",
    px = 34,
    py = 34
}

SMODS.Atlas { -- Main Voucher Atlas
    key = 'Vouchers',
    path = "Vouchers.png",
    px = 71,
    py = 95
}
--#endregion

--#region Sounds --------------------------------------------------------------------------------------------
SMODS.Sound({
    key = 'perfect',
    path = 'perfect.ogg'
})

SMODS.Sound({
    key = 'eggsplosion',
    path = 'eggsplosion.ogg'
})

SMODS.Sound({
    key = 'hey',
    path = 'hey.ogg'
})

SMODS.Sound({
    key = 'joker',
    path = 'i\'m a joker.ogg'
})

SMODS.Sound({
    key = 'spirit_beh',
    path = 'spirit beh.ogg',
    pitch = 0.8
})

SMODS.Sound({
    key = 'spirit_miss',
    path = 'spirit miss.ogg'
})

SMODS.Sound({
    key = 'spirit_ough',
    path = 'spirit ough.ogg'
})

SMODS.Sound({
    key = 'spirit_pow',
    path = 'spirit pow.ogg'
})

SMODS.Sound({
    key = 'clown_horn',
    path = 'clown horn.ogg'
})

SMODS.Sound({
    key = 'semisolid',
    path = 'voice_semisolidplatform.ogg'
})

--#endregion
