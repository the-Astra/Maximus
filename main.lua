-- CONFIG
--#region Config --------------------------------------------------------------------------------------------
Maximus = SMODS.current_mod
Maximus_path = SMODS.current_mod.path
Maximus_config = SMODS.current_mod.config

-- Config Menu
Maximus.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6 },
        nodes = {
            { n = G.UIT.R, config = { align = "cl", padding = 0, minh = 0.1 },      nodes = {} },

            -- 4D Ticking Toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "four_d_ticks" },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "c", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = localize('b_mxms_4d_ticking'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            -- Maximus Jokers Only toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "only_maximus_jokers" },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "c", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = localize('b_mxms_only_maximus_jokers'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            -- Horoscopes Toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "horoscopes", callback = G.FUNCS.mxms_toggle_horoscopes },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "c", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = localize('b_mxms_enable_horoscopes'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            -- Conspiracies Toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "conspiracies", callback = G.FUNCS.mxms_toggle_conspiracies },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "c", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = localize('b_mxms_enable_conspiracies'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            { n = G.UIT.R, config = { minh = 0.04, minw = 4, colour = G.C.L_BLACK } },

            -- Custom Menu Toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "menu" },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "c", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = localize('b_mxms_custom_menu'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            -- New Handtypes Toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "new_handtypes" },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "c", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = localize('b_mxms_enable_handtypes'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.5 },
                nodes = {
                    { n = G.UIT.T, config = { text = localize('b_mxms_restart_settings'), scale = 0.40, colour = G.C.UI.TEXT_LIGHT } },
                }
            },

        }
    }
end

-- Credits Tab - Derived from JoyousSpring credits tab
SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = localize('b_mxms_credits'),
            tab_definition_function = function()
                local modNodes = {}

                modNodes[#modNodes + 1] = {}
                local loc_vars = {
                    background_colour = G.C.CLEAR,
                    text_colour = G.C.WHITE,
                    scale = 1.4,
                    vars = {
                        elements = {
                            SMODS.create_sprite(0, 0, 6.6, 6.6 * (G.ASSET_ATLAS["mxms_logo"].py / G.ASSET_ATLAS["mxms_logo"].px), "mxms_logo", {x = 0, y = 0})
                        },
                        colours = {
                            G.C.PURPLE,
                            G.C.ATTENTION,
                            Maximus.C.SECONDARY_SET.Conspiracy,
                            G.C.GREEN,
                            G.C.SECONDARY_SET.Planet,
                            G.C.RED,
                            G.C.GOLD
                        }
                    }
                }
                localize { type = 'descriptions', key = 'mxms_credits', set = 'Other', nodes = modNodes[#modNodes], vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow }
                modNodes[#modNodes] = desc_from_rows(modNodes[#modNodes])
                modNodes[#modNodes].config.colour = loc_vars.background_colour or modNodes[#modNodes].config.colour

                return {
                    n = G.UIT.ROOT,
                    config = {
                        emboss = 0.05,
                        minh = 6,
                        r = 0.1,
                        minw = 6,
                        align = "tm",
                        padding = 0.2,
                        colour = G.C.BLACK
                    },
                    nodes = modNodes
                }
            end
        }
    }
end

-- load update.lua
assert(SMODS.load_file("update.lua"))()

--#endregion

--#region SMODS Optional Features ---------------------------------------------------------------------------

SMODS.current_mod.optional_features = { retrigger_joker = true, post_trigger = true, cardareas = { unscored = true } }

--#endregion

--#region Menu stuff ----------------------------------------------------------------------------------------
local oldfunc = Game.main_menu
function Game:main_menu(change_context)
    local ret = oldfunc(self, change_context)

    if Maximus_config.menu then
        -- Creates Maximus Logo Sprite
        local SC_scale = 1.1 * (G.debug_splash_size_toggle and 0.8 or 1)
        G.SPLASH_MAXIMUS_LOGO = Sprite(0, 0,
            6 * SC_scale,
            6 * SC_scale * (G.ASSET_ATLAS["mxms_logo"].py / G.ASSET_ATLAS["mxms_logo"].px),
            G.ASSET_ATLAS["mxms_logo"], { x = 0, y = 0 }
        )
        G.SPLASH_MAXIMUS_LOGO:set_alignment({
            major = G.title_top,
            type = 'cm',
            bond = 'Strong',
            offset = { x = 0, y = 3 }
        })
        G.SPLASH_MAXIMUS_LOGO:define_draw_steps({ {
            shader = 'dissolve',
        } })

        -- Define logo properties
        G.SPLASH_MAXIMUS_LOGO.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }

        G.SPLASH_MAXIMUS_LOGO.dissolve_colours = { Maximus.C.MXMS_PRIMARY, Maximus.C.MXMS_SECONDARY }
        G.SPLASH_MAXIMUS_LOGO.dissolve = 1

        G.SPLASH_MAXIMUS_LOGO.states.collide.can = true

        -- Define node functions for Maximus Logo
        function G.SPLASH_MAXIMUS_LOGO:click()
            play_sound('button', 1, 0.3)
            SMODS.LAST_SELECTED_MOD_TAB = nil
            G.FUNCS['openModUI_Maximus']()
            G.OVERLAY_MENU:get_UIE_by_ID("overlay_menu_back_button").config.button = "exit_overlay_menu_mxms"
        end

        G.FUNCS.exit_overlay_menu_mxms = function()
            G.ACTIVE_MOD_UI = nil
            G.FUNCS.exit_overlay_menu()
        end

        function G.SPLASH_MAXIMUS_LOGO:hover()
            G.SPLASH_MAXIMUS_LOGO:juice_up(0.05, 0.03)
            play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)
            Node.hover(self)
        end

        function G.SPLASH_MAXIMUS_LOGO:stop_hover() Node.stop_hover(self) end

        --Logo animation
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = change_context == 'splash' and 3.6 or change_context == 'game' and 4 or 1,
            blockable = false,
            blocking = false,
            func = (function()
                play_sound('magic_crumple' .. (change_context == 'splash' and 2 or 3),
                    (change_context == 'splash' and 1 or 1.3), 0.9)
                play_sound('whoosh1', 0.2, 0.8)
                ease_value(G.SPLASH_MAXIMUS_LOGO, 'dissolve', -1, nil, nil, nil,
                    change_context == 'splash' and 2.3 or 0.9)
                G.VIBRATION = G.VIBRATION + 1.5
                return true
            end)
        }))

        -- make the title screen use different background colors
        G.SPLASH_BACK:define_draw_steps({ {
            shader = 'splash',
            send = {
                { name = 'time',       ref_table = G.TIMERS,  ref_value = 'REAL_SHADER' },
                { name = 'vort_speed', val = 0.4 },
                { name = 'colour_1',   ref_table = Maximus.C, ref_value = 'MXMS_PRIMARY' },
                { name = 'colour_2',   ref_table = Maximus.C, ref_value = 'MXMS_SECONDARY' },
            }
        } })
    end

    Maximus.update_check()

    return ret
end

Maximus.menu_cards = function()
    if Maximus_config.menu and G.P_CENTERS['j_mxms_normal'] then
        return {
            { key = 'j_mxms_normal' }
        }
    end
end

--#endregion


-- ASSETS
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


-- CROSS-MOD
--#region Talisman compat -----------------------------------------------------------------------------------

to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end

--#endregion

--#region TheFamily compat ----------------------------------------------------------------------------------
if TheFamily then
    TheFamily.create_tab_group({
        key = "Maximus",
        order = 1,
    })
    TheFamily.create_tab({
        key = "horoscope",
        group_key = "Maximus",
        type = "switch",
        keep = true,

        front_label = function(definition, card)
            return {
                text = localize('b_mxms_stat_horoscopes'),
                colour = Maximus.C.HOROSCOPE,
                scale = 0.5,
            }
        end,
        center = "c_mxms_taurus",

        popup = function(definition, card)
            return {
                name = {
                    {
                        n = G.UIT.T,
                        config = {
                            text = localize('b_mxms_stat_horoscopes'),
                            colour = Maximus.C.HOROSCOPE,
                            scale = 0.4,
                        },
                    },
                },
                description = {
                    {
                        {
                            n = G.UIT.T,
                            config = {
                                text = "Show/Hide the Maximus Horoscope card area",
                                scale = 0.3,
                                colour = G.C.BLACK,
                            },
                        },
                    },
                },
            }
        end,
        keep_popup_when_highlighted = false,
        alert = function(definition, card)
            if not G.GAME.horoscope_alert or G.mxms_horoscope.states.visible then
                G.GAME.horoscope_alert = false
                return {
                    remove = true,
                }
            end
            return {
                text = "!",
            }
        end,
        highlight = function(definition, card)
            if Maximus_config.horoscopes then
                G.mxms_horoscope.states.visible = true
                G.GAME.horoscope_alert = false
            end
        end,
        unhighlight = function(definition, card)
            if Maximus_config.horoscopes then
                G.mxms_horoscope.states.visible = false
            end
        end,
    })
end
--#endregion

--#region JokerDisplay compat -------------------------------------------------------------------------------
if JokerDisplay then
    assert(SMODS.load_file("jd_def.lua"))()
end
--#endregion

--#region PlayLog compat -----------------------------------------------------------------------------------
if PlayLog and Maximus_config.horoscopes then
    PlayLog.LogType {
        key = 'mxms_horoscope_success',
        group = "effects",
        get_message = function(self, args)
            return PlayLog.localize(self.key, {PlayLog.format_object(args.card)})
        end
    }

    PlayLog.LogType {
        key = 'mxms_horoscope_fail',
        group = "effects",
        get_message = function(self, args)
            return PlayLog.localize(self.key, {PlayLog.format_object(args.card)})
        end
    }

    PlayLog.LogType {
        key = 'mxms_horoscope_increment',
        group = "effects",
        get_message = function(self, args)
            return PlayLog.localize(self.key, {PlayLog.format_object(args.card), args.tally - 1, args.tally})
        end
    }

    local plgan = PlayLog.get_area_name
    PlayLog.get_area_name = function(area)
        if area == G.mxms_horoscope then
            return PlayLog.localize('horoscope_area')
        end
        return plgan(area)
    end
end
--#endregion


-- FUNCTIONS
--#region Load Func Files -----------------------------------------------------------------------------------

assert(SMODS.load_file('src/overrides.lua'))()
assert(SMODS.load_file('src/utils.lua'))()
assert(SMODS.load_file('src/credits.lua'))()

--#endregion


-- OBJECTS
--#region Achievements --------------------------------------------------------------------------------------

assert(SMODS.load_file('items/achievements.lua'))()
sendDebugMessage("Loaded Achievements", 'Maximus')

--#endregion

--#region Attributes ----------------------------------------------------------------------------------------

SMODS.Attribute {
    key = 'voucher'
}

SMODS.Attribute {
    key = 'level_up',
    keys = { 'j_space' }
}

SMODS.Attribute {
    key = 'unscoring'
}

SMODS.Attribute {
    key = 'mod_scaling'
}

SMODS.Attribute {
    key = 'conspiracy'
}

SMODS.Attribute {
    key = 'horoscope'
}

--#endregion

--#region Backs ---------------------------------------------------------------------------------------------

local ENABLED_BACKS = {
    'sixth_finger',
    'nirvana',
    'nuclear',
    'professional',
    'grilled',
    'autographed',
    'destiny',
    'scarred',
    'empire',
    'dummy',
    'censored'
}

sendDebugMessage("Loading Backs...", 'Maximus')
for i = 1, #ENABLED_BACKS do
    assert(SMODS.load_file('items/backs/' .. ENABLED_BACKS[i] .. '.lua'))()
    sendDebugMessage("Loaded deck: " .. ENABLED_BACKS[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#region Sleeves ---------------------------------------------------------------------------------------

if CardSleeves then
    SMODS.Atlas { -- Main Sleeve Atlas
        key = 'Sleeves',
        path = "Sleeves.png",
        px = 73,
        py = 95
    }

    sendDebugMessage("Card Sleeves detected; Loading Sleeves...", 'Maximus')
    for i = 1, #ENABLED_BACKS do
        assert(SMODS.load_file('items/backs/sleeves/' .. ENABLED_BACKS[i] .. '.lua'))()
        sendDebugMessage("Loaded Sleeve: " .. ENABLED_BACKS[i], 'Maximus')
    end
    sendDebugMessage("", 'Maximus')
end

--#endregion

--#endregion

--#region Blinds --------------------------------------------------------------------------------------------

SMODS.Atlas { -- Main Blind Atlas
    key = 'Blinds',
    path = "Blinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

local ENABLED_BLINDS = {
    'rot',
    'grinder',
    'envy',
    'flame',
    'rule',
    'cheat',
    'hurdle',
    'spring',
    'bird',
    'maze',
}

sendDebugMessage("Loading Blinds...", 'Maximus')
for i = 1, #ENABLED_BLINDS do
    assert(SMODS.load_file('items/blinds/' .. ENABLED_BLINDS[i] .. '.lua'))()
    sendDebugMessage("Loaded blind: " .. ENABLED_BLINDS[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Boosters ------------------------------------------------------------------------------------------

sendDebugMessage("Loading Boosters...", 'Maximus')

assert(SMODS.load_file('items/boosters/zodiac_packs.lua'))()
sendDebugMessage("Loaded booster set: Zodiac", 'Maximus')

assert(SMODS.load_file('items/boosters/classified_packs.lua'))()
sendDebugMessage("Loaded booster set: Classified", 'Maximus')

sendDebugMessage("", 'Maximus')


--#endregion

--#region Challenges ----------------------------------------------------------------------------------------

local ENABLED_CHALLENGES = {
    '52_commandments',
    'crusaders',
    'overgrowth',
    'square',
    'gambling',
    'target_practice',
    'biggest_loser',
    'picky',
    'fashion',
    'all_stars',
    'p2w',
    'killer',
    'drain',
    'thought',
    'love_and_war',
    'despite_everything',
    'coexist',
    'feast',
    'speedrun',
    'greedy',
}

sendDebugMessage("Loading Challenges...", 'Maximus')
for i = 1, #ENABLED_CHALLENGES do
    assert(SMODS.load_file('items/challenges/' .. ENABLED_CHALLENGES[i] .. '.lua'))()
    sendDebugMessage("Loaded challenge: " .. ENABLED_CHALLENGES[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Conspiracy ----------------------------------------------------------------------------------------
SMODS.Atlas { -- Main Conspiracy Atlas
    key = 'Conspiracy',
    path = "Conspiracy.png",
    px = 71,
    py = 95
}

-- Conspiracy Type
SMODS.ConsumableType {
    key = 'Conspiracy',
    primary_colour = Maximus.C.SET.Conspiracy,
    secondary_colour = Maximus.C.SECONDARY_SET.Conspiracy,
    default = 'c_mxms_sighting',
    collection_rows = { 7, 7 },
    shop_rate = 1
}

local ENABLED_CONSPIRACIES = {
    'assassination',
    'sighting',
    'coverup',
    'hoax',
    'pyramid',
    'vaccine',
    'nwo',
    'corruption',
    'woke',
    'mib',
    'flat_earth',
    'landing',
    '5g',
    'tinfoil',
}

sendDebugMessage("Loading Conspiracies...", 'Maximus')
for i = 1, #ENABLED_CONSPIRACIES do
    assert(SMODS.load_file('items/conspiracy/' .. ENABLED_CONSPIRACIES[i] .. '.lua'))()
    sendDebugMessage("Loaded conspiracy: " .. ENABLED_CONSPIRACIES[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')
--#endregion

--#region Consumables ---------------------------------------------------------------------------------------

SMODS.Atlas { -- Main Consumable Atlas
    key = 'Consumables',
    path = "Consumables.png",
    px = 71,
    py = 95
}

local ENABLED_CONSUMABLES = {
    -- Planets
    'microscopii',
    'wasp',
    'pegasi',
    'trappist',
    'corot',
    'poltergeist',
    'gliese',
    'cancri',
    'proxima',
    'phobetor',
    'kepler',

    -- Spectrals
    'doppelganger',
    'immortality',

    -- Tarots
    'aeon',
}

sendDebugMessage("Loading Consumables...", 'Maximus')
for i = 1, #ENABLED_CONSUMABLES do
    assert(SMODS.load_file('items/consumables/' .. ENABLED_CONSUMABLES[i] .. '.lua'))()
    sendDebugMessage("Loaded consumable: " .. ENABLED_CONSUMABLES[i], 'Maximus')
end

sendDebugMessage("", 'Maximus')

--#endregion

--#region Hand Types ----------------------------------------------------------------------------------------

if Maximus_config.new_handtypes then
    --#region Hand Parts ------------------------------------------------------------------------------------
    local ENABLED_HAND_PARTS = {
        '_6',
        's_flush',
        's_straight'
    }

    sendDebugMessage("Loading Hand Parts...", 'Maximus')
    for i = 1, #ENABLED_HAND_PARTS do
        assert(SMODS.load_file('items/handtypes/parts/' .. ENABLED_HAND_PARTS[i] .. '.lua'))()
        sendDebugMessage("Loaded hand part: " .. ENABLED_HAND_PARTS[i], 'Maximus')
    end
    --#endregion

    local ENABLED_HANDS = {
        'three_pair',
        'double_triple',
        '6oak',
        's_straight',
        's_flush',
        'house_party',
        'f_three_pair',
        'f_double_triple',
        's_straight_f',
        'f_party',
        'f_6oak',
    }

    sendDebugMessage("Loading Hand Types...", 'Maximus')
    for i = 1, #ENABLED_HANDS do
        assert(SMODS.load_file('items/handtypes/' .. ENABLED_HANDS[i] .. '.lua'))()
        sendDebugMessage("Loaded hand type: " .. ENABLED_HANDS[i], 'Maximus')
    end
else
    sendDebugMessage("New hand types disabled; Skipping hands...", 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Horoscope -----------------------------------------------------------------------------------------

-- Horoscope Type

SMODS.ConsumableType {
    key = 'Horoscope',
    primary_colour = Maximus.C.SET.Horoscope,
    secondary_colour = Maximus.C.SECONDARY_SET.Horoscope,
    default = 'c_mxms_taurus',
    collection_rows = { 3, 3 },
    shop_rate = 0.0,
    select_card = 'mxms_horoscope'
}

local ENABLED_HOROSCOPES = {
    'aries',
    'taurus',
    'gemini',
    'cancer',
    'leo',
    'virgo',
    'libra',
    'scorpio',
    'sagittarius',
    'capricorn',
    'aquarius',
    'pisces',
    'ophiucus',
}

sendDebugMessage("Loading Horoscopes...", 'Maximus')
for i = 1, #ENABLED_HOROSCOPES do
    assert(SMODS.load_file('items/horoscopes/' .. ENABLED_HOROSCOPES[i] .. '.lua'))()
    sendDebugMessage("Loaded horoscope: " .. ENABLED_HOROSCOPES[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')
--#endregion

--#region Jokers --------------------------------------------------------------------------------------------

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

Maximus.ENABLED_JOKERS = { -- Comment out item to disable

    --Misc
    --Common
    'normal',
    'perspective',
    'harmony',
    'hopscotch',
    'salt_circle',
    'light_show',
    'marco_polo',
    'go_fish',
    'group_chat',
    'minimalist',
    'first_aid_kit',
    'kings_rook',
    'smoker',
    'cleaner',
    'vinyl_record',
    'spam',
    'unpleasant_gradient',
    'messiah',
    'werewolf',
    'wild_buddy',
    'bones_jr',
    'conveyor_belt',
    'golden_rings',
    'bear',
    'brown',
    'bankrupt',
    'spare_tire',
    'teddy_bear',
    'lucy',
    'detective',
    'brainwashed',
    'piggy_bank',
    'boar_bank',
    'honorable',
    'sneaky_spirit',
    'spider',
    'blue_tang',
    'context',
    'semisolid',
    'substitute',

    --Uncommon
    'war',
    'faded',
    'old_man_jimbo',
    'impractical',
    'pessimistic',
    'secret_society',
    'bullseye',
    'four_leaf_clover',
    'soyjoke',
    'clown_car',
    '4d',
    'virus',
    'man_in_the_mirror',
    'random_encounter',
    'trick_or_treat',
    'bell_curve',
    'loaded_gun',
    'dmiid',
    'poet',
    'gravity',
    'fog',
    'memory_game',
    'rock_slide',
    'review',
    'slippery_slope',
    'high_dive',
    'whos_on_first',
    'gutbuster',
    'galaxy_brain',
    'welder',
    'prospector',
    'blackjack',
    'tar_pit',
    'screaming',
    'rud',
    'couch_gag',

    --Rare
    'abyss',
    'combo_breaker',
    'joker+',
    'hammer_and_chisel',
    'streaker',
    'jobber',
    'dark_room',
    'guillotine',
    'soil',
    'stop_sign',
    'chihuahua',
    'vulture',
    'sisillyan',
    'under_construction',
    'adrenaline',

    --High Card Duo
    'loony',
    'lazy',

    --Food-Related
    'fortune_cookie',
    'breadsticks',
    'leftovers',
    'comedian',
    'pizza',
    'gelatin',
    'tofu',
    'rock_candy',
    'microwave',
    'refrigerator',
    'chef',
    'four_course_meal',

    --Glass Gang
    'poindexter',
    'stone_thrower',
    'pngoker',
    'glass_cannon',

    --Royals
    'coronation',
    'crowned',

    --Space
    'moon_landing',
    'space_race',

    --Blueprint-like
    'little_brother',
    'zombie',
    'bootleg',

    --Astra's Playlist
    'icosahedron',
    'celestial_deity',
    'abyss_angel',
    'god_hand',
    'sisyphus',
    'prince',

    --Thought Experiments
    'occam',
    'schrodinger',
    'chekhov',

    --God Cards
    'slifer',
    'obelisk',
    'ra',

    --Cowboy Bebop
    'space_cowboy',
    'gangster_love',
    'maurice',

    --Metamorphosis Trio
    'caterpillar',
    'chrysalis',
    'butterfly',

    --Shoppers
    'monk',
    'sleuth',
    'lint',
    'coupon',
    'hedonist',
    'power_creep',

    --Moneymakers
    'gambler',
    'hypeman',
    'fools_gold',
    'trashman',
    'paperclip',
    'jackpot',
    'jestcoin',
    'severed_floor',
    'change',

    --Horoscope Jokers
    'hippie',
    'letter',
    'employee',
    'nomai',
    'cheat_day',

    --Conspiracy Jokers
    'grifter',
    'red_yarn',
    'cork_board',
    'illuminati',
    'ufo',
    'bigfool',
    'hush_money',
    'apophenia',

    --Legendaries
    'ledger',
    'galifianakis',
    'romero',
    'leto',
    'nicholson',
    'phoenix',
    'hamill',
    'hugo',
    'raz',
}

sendDebugMessage("Loading Jokers...", 'Maximus')
for i = 1, #Maximus.ENABLED_JOKERS do
    assert(SMODS.load_file('items/jokers/' .. Maximus.ENABLED_JOKERS[i] .. '.lua'))()
    sendDebugMessage("Loaded joker: " .. Maximus.ENABLED_JOKERS[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Modifiers -----------------------------------------------------------------------------------------

local ENABLED_MODIFIERS = {
    'black',
    'posted',
    'footprint',
}
sendDebugMessage("Loading Card Modifiers...", 'Maximus')
for i = 1, #ENABLED_MODIFIERS do
    assert(SMODS.load_file('items/modifiers/' .. ENABLED_MODIFIERS[i] .. '.lua'))()
    sendDebugMessage("Loaded Card Modifier: " .. ENABLED_MODIFIERS[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')


--#endregion

--#region Tags ----------------------------------------------------------------------------------------------

SMODS.Atlas { -- Main Tag Atlas
    key = "Tags",
    path = "Tags.png",
    px = 34,
    py = 34
}

local ENABLED_TAGS = {
    'star',
    'crab',
    'lion',
    'maiden',
    'ram',
    'scale',
}

sendDebugMessage("Loading Tags...", 'Maximus')

for i = 1, #ENABLED_TAGS do
    assert(SMODS.load_file('items/tags/' .. ENABLED_TAGS[i] .. '.lua'))()
    sendDebugMessage("Loaded tag: " .. ENABLED_TAGS[i], 'Maximus')
end

sendDebugMessage("", 'Maximus')


--#endregion

--#region Vouchers ------------------------------------------------------------------------------------------

SMODS.Atlas { -- Main Voucher Atlas
    key = 'Vouchers',
    path = "Vouchers.png",
    px = 71,
    py = 95
}

local ENABLED_VOUCHERS = {
    'launch_code',
    'warp_drive',
    'sharp_suit',
    'best_dressed',
    'shield',
    'guardian',
    'multitask',
    'workaholic',
    'whistleblower',
    'declassified'
}

sendDebugMessage("Loading Vouchers...", 'Maximus')
for i = 1, #ENABLED_VOUCHERS do
    assert(SMODS.load_file('items/vouchers/' .. ENABLED_VOUCHERS[i] .. '.lua'))()
    sendDebugMessage("Loaded voucher: " .. ENABLED_VOUCHERS[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#endregion
