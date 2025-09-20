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

            -- Horoscopes Toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "horoscopes" },
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

-- Credits Tab - Derived from Joyous Spring credits tab
SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = localize('b_mxms_credits'),
            tab_definition_function = function()
                local modNodes = {}

                modNodes[#modNodes + 1] = {}
                local loc_vars = { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.4 }
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
Game.main_menu = function(change_context)
    local ret = oldfunc(change_context)

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
            G.FUNCS['openModUI_Maximus']()
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

        -- adds a James to the main menu
        local newcard = create_card('Joker', G.title_top, nil, nil, nil, nil, 'j_mxms_normal', 'astra')

        -- recenter the title
        G.title_top.T.w = G.title_top.T.w * 1.7675
        G.title_top.T.x = G.title_top.T.x - 0.8
        G.title_top:emplace(newcard)

        -- make the card look the same way as the title screen Ace of Spades
        newcard.T.w = newcard.T.w * 1.1 * 1.2
        newcard.T.h = newcard.T.h * 1.1 * 1.2
        newcard.no_ui = true
        newcard.states.visible = false

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

        -- materialize James
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0,
            blockable = false,
            blocking = false,
            func = function()
                if change_context == "splash" then
                    newcard.states.visible = true
                    newcard:start_materialize({ G.C.WHITE, Maximus.C.MXMS_SECONDARY }, true, 2.5)
                else
                    newcard.states.visible = true
                    newcard:start_materialize({ G.C.WHITE, Maximus.C.MXMS_SECONDARY }, nil, 1.2)
                end
                return true
            end,
        }))
    end

    Maximus.update_check()

    return ret
end

--#endregion


-- ASSETS
--#region Colors --------------------------------------------------------------------------------------------

Maximus.C = {
    MXMS_PRIMARY = HEX('7855fc'),
    MXMS_SECONDARY = HEX('901b7f'),
    HOROSCOPE = HEX('e86fa5'),
    SET = {
        Horoscope = HEX('d9629c')
    },
    SECONDARY_SET = {
        Horoscope = HEX('a64d79')
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
if TheFamily and Maximus_config.horoscopes then
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
            G.mxms_horoscope.states.visible = true
            G.GAME.horoscope_alert = false
        end,
        unhighlight = function(definition, card)
            G.mxms_horoscope.states.visible = false
        end,
    })
end
--#endregion

--#region JokerDisplay compat -------------------------------------------------------------------------------
if JokerDisplay then
    assert(SMODS.load_file("jd_def.lua"))()
end
--#endregion


-- VARIABLES
--#region Misc Variables ------------------------------------------------------------------------------------
Maximus.vanilla_food = {
    j_gros_michel = true,
    j_egg = true,
    j_ice_cream = true,
    j_cavendish = true,
    j_turtle_bean = true,
    j_diet_cola = true,
    j_popcorn = true,
    j_ramen = true,
    j_selzer = true,
}

if not SMODS.ObjectTypes.Food then
    SMODS.ObjectType {
        key = 'Food',
        default = 'j_egg',
        cards = {
            j_gros_michel = true,
            j_selzer = true,
            j_egg = true,
            j_ice_cream = true,
            j_popcorn = true,
            j_cavendish = true,
            j_turtle_bean = true,
            j_diet_cola = true,
            j_ramen = true
        },
    }
end

Maximus.invert_prob_cards = {
    j_gros_michel = true,
    j_cavendish = true,
    j_mxms_hugo = true,
    j_mxms_jestcoin = true,
    c_ankh = true,
    c_hex = true,
    m_glass = true
}
--#endregion

--#region Round Changing Variables --------------------------------------------------------------------------
function SMODS.current_mod.reset_game_globals(run_start)
    -- Impractical Joker
    if G.GAME.challenge == 'c_mxms_biggest_loser' then
        G.GAME.current_round.mxms_impractical_hand = 'Straight Flush'
    elseif G.GAME.round ~= 1 then
        G.GAME.current_round.mxms_impractical_hand = G.GAME.current_round.mxms_impractical_hand
        local valid_hands = {}

        for k, v in pairs(G.GAME.hands) do
            if v.visible then
                valid_hands[#valid_hands + 1] = k
            end
        end

        local new_hand = G.GAME.current_round.mxms_impractical_hand
        while new_hand == G.GAME.current_round.mxms_impractical_hand do
            new_hand = pseudorandom_element(valid_hands, pseudoseed('impractical' .. G.GAME.round_resets.ante))
        end
        G.GAME.current_round.mxms_impractical_hand = new_hand
    end

    -- Marco Polo
    if G.GAME.round ~= 1 then
        local new_pos = G.GAME.current_round.mxms_marco_polo_pos
        if #G.jokers.cards <= 1 then
            new_pos = 1
        else
            while new_pos == G.GAME.current_round.mxms_marco_polo_pos do
                new_pos = pseudorandom(pseudoseed('marcopolo' .. G.GAME.round_resets.ante), 1, #G.jokers.cards)
            end
        end
        G.GAME.current_round.mxms_marco_polo_pos = new_pos
    end

    -- Go Fish
    if G.GAME.round ~= 1 then
        local valid_ranks = {}
        local new_rank = G.GAME.current_round.mxms_go_fish.rank
        local new_mult = 0
        for k, v in ipairs(G.playing_cards) do
            valid_ranks[#valid_ranks + 1] = v.base.value
        end
        new_rank = pseudorandom_element(valid_ranks, pseudoseed('mxms_go_fish' .. G.GAME.round_resets.ante))
        G.GAME.current_round.mxms_go_fish.rank = new_rank
        for k, v in ipairs(valid_ranks) do
            if v == new_rank then
                new_mult = new_mult + 1
            end
        end
        G.GAME.current_round.mxms_go_fish.mult = new_mult * 2
    end

    -- Zombie
    if next(SMODS.find_card('j_mxms_zombie')) and G.GAME.current_round.mxms_zombie_target.card ~= nil then
        if not SMODS.is_eternal(G.GAME.current_round.mxms_zombie_target.card) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    delay(0.4)
                    G.GAME.current_round.mxms_zombie_target.card:set_ability(G.P_CENTERS['j_mxms_zombie'])
                    G.GAME.current_round.mxms_zombie_target.card:juice_up(0.8, 0.8)
                    delay(0.4)
                    SMODS.calculate_effect({ message = localize('k_mxms_turned_ex'), colour = G.C.GREEN },
                        G.GAME.current_round.mxms_zombie_target.card)
                    G.GAME.current_round.mxms_zombie_target.card = nil

                    check_for_unlock({ type = "zombified" })
                    return true
                end
            }))
        end
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
            local eligible_jokers = {}
            local new_target = G.GAME.current_round.mxms_zombie_target.card
            if #G.jokers.cards <= 1 or not next(SMODS.find_card('j_mxms_zombie')) then
                new_target = nil
            else
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].config.center_key ~= 'j_mxms_zombie' and G.jokers.cards[i] ~= new_target and G.jokers.cards[i].config.center.blueprint_compat then
                        eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                    end
                end
                if next(eligible_jokers) then
                    new_target = pseudorandom_element(eligible_jokers,
                        pseudoseed('zombie' .. G.GAME.round_resets.ante))
                else
                    new_target = nil
                end
            end

            G.GAME.current_round.mxms_zombie_target.card = new_target
            if G.GAME.current_round.mxms_zombie_target.card ~= nil then
                SMODS.calculate_effect({ message = localize('k_mxms_infected_ex'), colour = G.C.GREEN },
                    G.GAME.current_round.mxms_zombie_target.card)
            end
            return true
        end
    }))


    -- Jello
    local jello_suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.mxms_jello_suit then jello_suits[#jello_suits + 1] = v end
    end
    G.GAME.current_round.mxms_jello_suit = pseudorandom_element(jello_suits,
        pseudoseed('jel' .. G.GAME.round_resets.ante))
end

--#endregion


-- FUNCTIONS
--#region Function Hooks ------------------------------------------------------------------------------------

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)

    -- Conditional/tracking Modifiers
    ret.mxms_choose_mod = 0
    ret.mxms_war_mod = 1
    ret.mxms_fridge_mod = 1
    ret.mxms_soy_mod = 0
    ret.mxms_purchased_jokers = {}
    ret.mxms_gambler_mod = 1
    ret.mxms_creep_mod = 1
    ret.mxms_soil_mod = 1
    ret.mxms_skip_tag = ''
    ret.mxms_last_bought = {
        card = nil,
        pos = nil
    }
    ret.mxms_v_destroy_reduction = 0
    ret.mxms_shop_price_multiplier = 1
    ret.mxms_base_planet_levels = 1
    ret.mxms_breadstick_scales = 0

    --Rotating Modifiers
    ret.current_round.mxms_impractical_hand = 'Straight Flush'
    ret.current_round.mxms_marco_polo_pos = 1
    ret.current_round.mxms_go_fish = {
        rank = "Ace",
        mult = 8
    }
    ret.current_round.mxms_zombie_target = {
        card = nil,
        pos = nil
    }
    ret.current_round.mxms_jello_suit = 'Spades'

    --Horoscope
    ret.mxms_horoscope_buffer = 0

    ret.zodiac_killer_pools = {
        ['Aries'] = true,
        ['Taurus'] = true,
        ['Gemini'] = true,
        ['Cancer'] = true,
        ['Leo'] = true,
        ['Virgo'] = true,
        ['Libra'] = true,
        ['Scorpio'] = true,
        ['Sagittarius'] = true,
        ['Capricorn'] = true,
        ['Aquarius'] = true,
        ['Pisces'] = true,
    }

    ret.astro_last_pack = 1

    ret.mxms_aries_bonus = false
    ret.mxms_cancer_bonus = 0
    ret.mxms_leo_bonus = 0
    ret.mxms_virgo_bonus = 0
    ret.mxms_libra_bonus = 0
    ret.mxms_sagittarius_bonus = false

    --Pool Flags
    ret.pool_flags.mxms_cavendish_removed = false

    return ret
end

-- after_scoring hook; derived from Ortalab
local draw_discard = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
    local obj = G.GAME.blind.config.blind
    if obj.after_scoring and not G.GAME.blind.disabled then
        obj:after_scoring()
    end
    draw_discard(e)
end

local save_r = save_run
save_run = function(self)
    if G.GAME.current_round.mxms_zombie_target and G.GAME.current_round.mxms_zombie_target.card then
        local pos = 1
        for k, v in pairs(G.jokers.cards) do
            if v == G.GAME.current_round.mxms_zombie_target.card then
                G.GAME.current_round.mxms_zombie_target.pos = pos
                break
            end
            pos = pos + 1
        end
    end

    if G.GAME.mxms_last_bought and G.GAME.mxms_last_bought.card then
        local pos = 1
        for k, v in pairs(G.jokers.cards) do
            if v == G.GAME.mxms_last_bought.card then
                G.GAME.mxms_last_bought.pos = pos
                break
            end
            pos = pos + 1
        end
    end

    local gutbusters = SMODS.find_card('j_mxms_gutbuster')
    if next(gutbusters) then
        for i = 1, #gutbusters do
            for k, v in ipairs(G.jokers.cards) do
                if gutbusters[i].ability.extra.card and v == gutbusters[i].ability.extra.card then
                    gutbusters[i].ability.extra.pos = k
                    break
                end
            end
        end
    end

    save_r(self)
end

local start_r = Game.start_run
---@diagnostic disable-next-line: duplicate-set-field
Game.start_run = function(self, args)
    start_r(self, args)

    if G.GAME.mxms_last_bought and G.GAME.mxms_last_bought.pos then
        G.GAME.mxms_last_bought.card = G.jokers.cards[G.GAME.mxms_last_bought.pos]
        G.GAME.mxms_last_bought.pos = nil
    end

    if G.GAME.current_round.mxms_zombie_target and G.GAME.current_round.mxms_zombie_target.pos then
        G.GAME.current_round.mxms_zombie_target.card = G.jokers.cards[G.GAME.current_round.mxms_zombie_target.pos]
        G.GAME.current_round.mxms_zombie_target.pos = nil
    end

    local gutbusters = SMODS.find_card('j_mxms_gutbuster')
    if next(gutbusters) then
        for i = 1, #gutbusters do
            if gutbusters[i].ability.extra.pos then
                gutbusters[i].ability.extra.card = G.jokers.cards[gutbusters[i].ability.extra.pos]
                gutbusters[i].ability.extra.pos = nil
            end
        end
    end
end

local csc = Card.set_cost
function Card:set_cost()
    csc(self)
    self.cost = math.floor(self.cost * G.GAME.mxms_shop_price_multiplier)
    self.cost = self.cost * G.GAME.mxms_creep_mod
end

-- Prevent other cards from spawning under certain conditions
local get_current_pool_ref = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)
    local _pool, _pool_key = get_current_pool_ref(_type, _rarity, _legendary, _append)
    local new_pool

    if _type == 'Joker' then
        if Maximus.config.only_maximus_jokers then
            for i = 1, #_pool do
                local key = _pool[i]
                if key:sub(1, 6) ~= "j_mxms" then
                    _pool[i] = "UNAVAILABLE"
                end
            end
        end

        if G.GAME.modifiers.mxms_feast then
            for i = 1, #_pool do
                local key = _pool[i]
                if not Maximus.is_food(key) and key ~= 'j_mxms_microwave' and key ~= 'j_mxms_refrigerator' then
                    _pool[i] = "UNAVAILABLE"
                end
            end
        end
    end
    return _pool, _pool_key
end

local cubt = create_UIBox_blind_tag
create_UIBox_blind_tag = function(blind_choice, run_info)
    if not G.GAME.modifiers.disable_blind_skips then
        return cubt(blind_choice, run_info)
    end
end

--#endregion

--#region Helper Functions ----------------------------------------------------------------------------------

function Maximus.reset_horoscopes()
    if G.GAME.mxms_aries_bonus then
        G.GAME.mxms_aries_bonus = false
    end
    if G.GAME.mxms_cancer_bonus > 0 then
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - G.GAME.mxms_cancer_bonus
        ease_hands_played(-G.GAME.mxms_cancer_bonus)
        G.GAME.mxms_cancer_bonus = 0
    end

    if G.GAME.mxms_leo_bonus > 0 then
        G.hand:change_size(-G.GAME.mxms_leo_bonus)
        G.GAME.mxms_leo_bonus = 0
    end

    if G.GAME.mxms_virgo_bonus > 0 then
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - G.GAME.mxms_virgo_bonus
        ease_discard(-G.GAME.mxms_virgo_bonus)
        G.GAME.mxms_virgo_bonus = 0
    end
end

-- Checks if a card should have an inverted check when evaluating prob results
function Maximus.is_invert_prob_check(card)
    if card.config and card.config.center then
        if Maximus.invert_prob_cards[card.config.center_key] then
            return true
        elseif next(SMODS.get_enhancements(card)) then
            for k, v in pairs(SMODS.get_enhancements(card)) do
                if Maximus.invert_prob_cards[v] then
                    return true
                end
            end
        end
    end
    return false
end

-- Forces a game over
function Maximus.force_game_over()
    G.E_MANAGER:add_event(Event({
        delay = 0.2,
        func = function()
            G.STATE = G.STATES.GAME_OVER
            if not G.GAME.seeded and not G.GAME.challenge then
                G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
            end
            G:save_settings()
            G.FILE_HANDLER.force = true
            G.STATE_COMPLETE = false
            return true;
        end
    }))
end

---Tallies Maximus cards from a given pool and possible subset; Derived from SMODS modCollectionTally
function Maximus.getMaximusTallies(pool, set)
    local set = set or nil
    local obj_tally = { tally = 0, of = 0 }

    for _, v in pairs(pool) do
        if v.mod and 'Maximus' == v.mod.id and not v.no_collection then
            if set then
                if v.set and v.set == set then
                    obj_tally.of = obj_tally.of + 1
                    if v.discovered then
                        obj_tally.tally = obj_tally.tally + 1
                    end
                end
            else
                obj_tally.of = obj_tally.of + 1
                if v.discovered then
                    obj_tally.tally = obj_tally.tally + 1
                end
            end
        end
    end

    return obj_tally
end

---Sets Horoscope success stats
function Maximus.set_horoscope_success(card)
    if G.PROFILES[G.SETTINGS.profile].horoscope_completions[card.config.center_key] then
        G.PROFILES[G.SETTINGS.profile].horoscope_completions[card.config.center_key].count = G.PROFILES
            [G.SETTINGS.profile].horoscope_completions[card.config.center_key].count + 1
    else
        G.PROFILES[G.SETTINGS.profile].horoscope_completions[card.config.center_key] = {
            count = 1,
            order = card.config.center.order
        }
    end
    G:save_settings()
end

---Returns the name of the most played poker hand
function Maximus.get_most_played_hand()
    local _handname, _played, _order = 'High Card', -1, 100
    for k, v in pairs(G.GAME.hands) do
        if v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            _handname = k
        end
    end

    return _handname
end

---Returns the range of rank chip values
function Maximus.get_nominal_sum()
    local highest, lowest = nil, nil
    for k, v in pairs(SMODS.Ranks) do
        if not highest and not lowest then
            highest = v.nominal
            lowest = v.nominal
        else
            if v.nominal > highest then
                highest = v.nominal
            elseif v.nominal < lowest then
                lowest = v.nominal
            end
        end
    end

    return highest + lowest
end

--#endregion


-- CREDITS SYSTEM
--#region Card Credits System (Derived from Cryptid's cry_credits) ------------------------------------------
local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    smcmb(obj, badges)
    if not SMODS.config.no_mod_badges and obj and obj.mxms_credits then
        local function calc_scale_fac(text)
            local size = 0.9
            local font = G.LANG.font
            local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
            local calced_text_width = 0
            -- Math reproduced from DynaText:update_text
            for _, c in utf8.chars(text) do
                local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
                    + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
                calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
            end
            local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
            return scale_fac
        end
        if obj.mxms_credits.art or obj.mxms_credits.code or obj.mxms_credits.idea or obj.mxms_credits.custom then
            local scale_fac = {}
            local min_scale_fac = 1
            local strings = { Maximus.display_name }
            for _, v in ipairs({ "idea", "art", "code" }) do
                if obj.mxms_credits[v] then
                    if type(obj.mxms_credits[v]) == "string" then obj.mxms_credits[v] = { obj.mxms_credits[v] } end
                    for i = 1, #obj.mxms_credits[v] do
                        strings[#strings + 1] =
                            localize({ type = "variable", key = "mxms_" .. v, vars = { obj.mxms_credits[v][i] } })[1]
                    end
                end
            end
            if obj.mxms_credits.custom then
                strings[#strings + 1] = localize({ type = "variable", key = obj.mxms_credits.custom.key, vars = { obj.mxms_credits.custom.text } })
            end
            for i = 1, #strings do
                scale_fac[i] = calc_scale_fac(strings[i])
                min_scale_fac = math.min(min_scale_fac, scale_fac[i])
            end
            local ct = {}
            for i = 1, #strings do
                ct[i] = {
                    string = strings[i],
                }
            end
            local mxms_badge = {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            colour = Maximus.badge_colour,
                            r = 0.1,
                            minw = 2 / min_scale_fac,
                            minh = 0.36,
                            emboss = 0.05,
                            padding = 0.03 * 0.9,
                        },
                        nodes = {
                            { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                            {
                                n = G.UIT.O,
                                config = {
                                    object = DynaText({
                                        string = ct or "ERROR",
                                        colours = { obj.mxms_credits and obj.mxms_credits.text_colour or Maximus.badge_text_colour },
                                        silent = true,
                                        float = true,
                                        shadow = true,
                                        offset_y = -0.03,
                                        spacing = 1,
                                        scale = 0.33 * 0.9,
                                    }),
                                },
                            },
                            { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                        },
                    },
                },
            }
            local function eq_col(x, y)
                for i = 1, 4 do
                    if x[i] ~= y[i] then
                        return false
                    end
                end
                return true
            end
            for i = 1, #badges do
                if badges[i].nodes[1].nodes[2].config.object.string == Maximus.display_name then --this was meant to be a hex code but it just doesnt work for like no reason so its hardcoded
                    badges[i].nodes[1].nodes[2].config.object:remove()
                    badges[i] = mxms_badge
                    break
                end
            end
        end
    end
end

--#endregion


-- OBJECTS
--#region Achievements --------------------------------------------------------------------------------------

assert(SMODS.load_file('items/achievements.lua'))()
sendDebugMessage("Loaded Achievements", 'Maximus')

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
    --'scarred',
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

SMODS.Atlas { -- Main Booster Atlas
    key = 'Boosters',
    path = "Boosters.png",
    px = 71,
    py = 95
}

local ENABLED_BOOSTERS = {
    'horoscope_normal_1',
    'horoscope_normal_2',
    'horoscope_jumbo_1',
    'horoscope_mega_1',
}

if Maximus_config.horoscopes then
    sendDebugMessage("Loading Boosters...", 'Maximus')
    for i = 1, #ENABLED_BOOSTERS do
        assert(SMODS.load_file('items/boosters/' .. ENABLED_BOOSTERS[i] .. '.lua'))()
        sendDebugMessage("Loaded booster: " .. ENABLED_BOOSTERS[i], 'Maximus')
    end
else
    sendDebugMessage("Horoscopes disabled; Skipping Boosters...", 'Maximus')
end
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
if Maximus_config.horoscopes then
    SMODS.ConsumableType {
        key = 'Horoscope',
        primary_colour = Maximus.C.SET.Horoscope,
        secondary_colour = Maximus.C.SECONDARY_SET.Horoscope,
        default = 'c_mxms_taurus',
        collection_rows = { 3, 3 },
        shop_rate = 0.0,
        select_card = 'mxms_horoscope'
    }

    -- CardArea emplace hook
    local cae = CardArea.emplace
    function CardArea:emplace(card, location, stay_flipped)
        if self == G.consumeables and (card.ability.set == "Horoscope" or card.config.center_key == 'c_mxms_ophiucus') then
            card:remove_from_area()
            G.mxms_horoscope:emplace(card, location, stay_flipped)
            discover_card(card.config.center)
            card.bypass_discovery_center = true
            card.bypass_discovery_ui = true
            card.discovered = true
            return
        end

        cae(self, card, location, stay_flipped)

        if self == G.mxms_horoscope and TheFamily then
            G.GAME.horoscope_alert = true
        end
    end

    -- Global calculates for Horoscope resetting and and Horoscope tag application
    Maximus.calculate = function(self, context)
        if context.ante_change and context.ante_end then
            Maximus.reset_horoscopes()
            for i = 1, #G.GAME.tags do
                G.GAME.tags[i]:apply_to_run({ type = 'start_apply_horoscopes' })
            end
        end
    end

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
end
--#endregion

--#region Jokers --------------------------------------------------------------------------------------------

SMODS.Atlas { -- Main Joker Atlas
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- 4D Joker Atlas
    key = '4D',
    path = "4d_joker.png",
    px = 71,
    py = 95
}

local ENABLED_JOKERS = { -- Comment out item to disable

    --Misc
    --Common
    'normal',
    'perspective',
    'harmony',
    'trick_or_treat',
    'hopscotch',
    'salt_circle',
    'light_show',
    'marco_polo',
    'go_fish',
    'group_chat',
    'minimalist',
    'memory_game',
    'first_aid_kit',
    'kings_rook',
    'smoker',
    'cleaner',
    'vinyl_record',
    'spam',
    'messiah',
    'werewolf',
    'wild_buddy',
    'bones_jr',
    'conveyor_belt',
    'golden_rings',
    'bear',
    'brown',
    'bankrupt',
    'teddy_bear',
    'lucy',
    'detective',
    'spare_tire',
    'piggy_bank',
    'boar_bank',
    'honorable',
    'sneaky_spirit',
    'spider',
    --'blue_tang',

    --Uncommon
    'war',
    'faded',
    'old_man_jimbo',
    'impractical',
    'pessimistic',
    'secret_society',
    'bullseye',
    'hammer_and_chisel',
    'four_leaf_clover',
    'soyjoke',
    'clown_car',
    '4d',
    'virus',
    'man_in_the_mirror',
    'unpleasant_gradient',
    'random_encounter',
    'bell_curve',
    'loaded_gun',
    'dmiid',
    'poet',
    'gravity',
    'fog',
    'rock_slide',
    'game_review',
    'slippery_slope',
    'high_dive',
    'brainwashed',
    'whos_on_first',
    'gutbuster',
    'galaxy_brain',
    'welder',
    'prospector',
    'blackjack',
    'tar_pit',
    'screaming',
    --'rud',

    --Rare
    'abyss',
    'combo_breaker',
    'joker+',
    'streaker',
    'jobber',
    'dark_room',
    'guillotine',
    'soil',
    'stop_sign',
    'chihuahua',
    'vulture',
    --'sisillyan',

    --High Card Duo
    'loony',
    'lazy',

    --Food-Related
    'chef',
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
    'coupon',
    'monk',
    'sleuth',
    'lint',
    'hedonist',
    'power_creep',

    --Moneymakers
    'gambler',
    'hypeman',
    'fools_gold',
    'trashman',
    --'paperclip',
    'jackpot',
    'jestcoin',
    'severed_floor',
    'change',

    --Horoscope Jokers
    'hippie',
    'cheat_day',
    'letter',
    'employee',
    'nomai',

    --Legendaries
    'ledger',
    'galifianakis',
    'romero',
    'leto',
    'nicholson',
    'phoenix',
    'hamill',
    'hugo',
}

sendDebugMessage("Loading Jokers...", 'Maximus')
for i = 1, #ENABLED_JOKERS do
    assert(SMODS.load_file('items/jokers/' .. ENABLED_JOKERS[i] .. '.lua'))()
    sendDebugMessage("Loaded joker: " .. ENABLED_JOKERS[i], 'Maximus')
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
}

sendDebugMessage("Loading Vouchers...", 'Maximus')
for i = 1, #ENABLED_VOUCHERS do
    assert(SMODS.load_file('items/vouchers/' .. ENABLED_VOUCHERS[i] .. '.lua'))()
    sendDebugMessage("Loaded voucher: " .. ENABLED_VOUCHERS[i], 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#endregion
