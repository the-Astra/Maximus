--#region Config
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
                            { n = G.UIT.T, config = { text = "Enable 4D Joker Ticking Sounds", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
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
                            { n = G.UIT.T, config = { text = "Enable Custom Menu", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            -- Experimental Features Toggle
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Maximus_config, ref_value = "experimental_features" },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "c", padding = 0 },
                        nodes = {
                            { n = G.UIT.T, config = { text = "Enable Experimental Features", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
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
                            { n = G.UIT.T, config = { text = "Enable Horoscopes", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                        }
                    },
                }
            },

            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.5 },
                nodes = {
                    { n = G.UIT.T, config = { text = "(Must restart to apply changes)", scale = 0.40, colour = G.C.UI.TEXT_LIGHT } },
                }
            },

        }
    }
end
--#endregion

--#region SMODS Optional Features ---------------------------------------------------------------------------

SMODS.current_mod.optional_features = { retrigger_joker = true, post_trigger = true, cardareas = { unscored = true } }

--#endregion

--#region Talisman compat

to_big = to_big or function(num)
    return num
end

function TalisHelper(num)
    if next(SMODS.find_mod('Talisman')) then
        return to_big(num)
    else
        return num
    end
end

--#endregion

--#region Atlases -------------------------------------------------------------------------------------------

SMODS.Atlas { -- Main Joker Atlas
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Placeholder Atlas
    key = 'Placeholder',
    path = "placeholders.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- 4D Joker Atlas
    key = '4D',
    path = "4d_joker.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Voucher Atlas
    key = 'Vouchers',
    path = "Vouchers.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Consumable Atlas
    key = 'Consumables',
    path = "Consumables.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Back Atlas
    key = 'Backs',
    path = "Backs.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Booster Atlas
    key = 'Boosters',
    path = "Boosters.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- Main Tag Atlas
    key = "Tags",
    path = "Tags.png",
    px = 34,
    py = 34
}

SMODS.Atlas { -- Main Blind Atlas
    key = 'Blinds',
    path = "Blinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

SMODS.Atlas { -- Mod Icon
    key = "modicon",
    path = "modicon.png",
    px = 32,
    py = 32
}

--#endregion

--#region Function Hooks ------------------------------------------------------------------------------------

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)

    -- Conditional/tracking Modifiers
    ret.choose_mod = 0
    ret.war_mod = 1
    ret.fridge_mod = 1
    ret.soy_mod = 0
    ret.purchased_jokers = {}
    ret.gambler_mod = 1
    ret.creep_mod = 1
    ret.soil_mod = 1
    ret.skip_tag = ''
    ret.last_bought = {
        card = nil,
        pos = nil
    }
    ret.v_destroy_reduction = 0
    ret.shop_price_multiplier = 1
    ret.horoscope_rate = 0
    ret.base_planet_levels = 1

    --Rotating Modifiers
    ret.current_round.impractical_hand = 'Straight Flush'
    ret.current_round.marco_polo_pos = 1
    ret.current_round.go_fish = {
        rank = "Ace",
        mult = 8
    }
    ret.current_round.zombie_target = {
        card = nil,
        pos = nil
    }
    ret.current_round.jello_suit = 'Spades'

    --Horoscope
    ret.horoscope_buffer = 0

    ret.next_ante_horoscopes = {
        ["Aries"] = false,
        ["Cancer"] = false,
        ["Leo"] = false,
        ["Virgo"] = false,
    }

    ret.aries_bonus = false
    ret.cancer_bonus = false
    ret.leo_bonus = false
    ret.virgo_bonus = false
    ret.libra_bonus = false
    ret.sagittarius_bonus = false

    --Pool Flags
    ret.pool_flags.cavendish_removed = false

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

-- Menu stuff
if Maximus_config.menu then
    local oldfunc = Game.main_menu
    Game.main_menu = function(change_context)
        local ret = oldfunc(change_context)
        if G.P_CENTERS['j_mxms_normal'].discovered then
            -- adds a James to the main menu
            local newcard = create_card('Joker', G.title_top, nil, nil, nil, nil, 'j_mxms_normal', 'astra')
            -- recenter the title
            G.title_top.T.w = G.title_top.T.w * 1.7675
            G.title_top.T.x = G.title_top.T.x - 0.8
            newcard:start_materialize({ G.C.WHITE, G.C.MXMS_SECONDARY }, true, 2.5)
            G.title_top:emplace(newcard)
            -- make the card look the same way as the title screen Ace of Spades
            newcard.T.w = newcard.T.w * 1.1 * 1.2
            newcard.T.h = newcard.T.h * 1.1 * 1.2
            newcard.no_ui = true
        end

        -- make the title screen use different background colors
        G.SPLASH_BACK:define_draw_steps({ {
            shader = 'splash',
            send = {
                { name = 'time',       ref_table = G.TIMERS, ref_value = 'REAL_SHADER' },
                { name = 'vort_speed', val = 0.4 },
                { name = 'colour_1',   ref_table = G.C,      ref_value = 'MXMS_PRIMARY' },
                { name = 'colour_2',   ref_table = G.C,      ref_value = 'MXMS_SECONDARY' },
            }
        } })

        return ret
    end
end

local save_r = save_run
save_run = function(self)
    if G.GAME.current_round.zombie_target and G.GAME.current_round.zombie_target.card then
        local pos = 1
        for k, v in pairs(G.jokers.cards) do
            if v == G.GAME.current_round.zombie_target.card then
                G.GAME.current_round.zombie_target.pos = pos
                break
            end
            pos = pos + 1
        end
    end

    if G.GAME.last_bought and G.GAME.last_bought.card then
        local pos = 1
        for k, v in pairs(G.jokers.cards) do
            if v == G.GAME.last_bought.card then
                G.GAME.last_bought.pos = pos
                break
            end
            pos = pos + 1
        end
    end

    local blockbusters = SMODS.find_card('j_mxms_blockbuster')
    if next(blockbusters) then
        for i = 1, #blockbusters do
            for k, v in ipairs(G.jokers.cards) do
                if blockbusters[i].ability.extra.card and v == blockbusters[i].ability.extra.card then
                    blockbusters[i].ability.extra.pos = k
                    break
                end
            end
        end
    end

    save_r(self)
end

local start_r = Game.start_run
Game.start_run = function(self, args)
    start_r(self, args)

    if G.GAME.last_bought and G.GAME.last_bought.pos then
        G.GAME.last_bought.card = G.jokers.cards[G.GAME.last_bought.pos]
        G.GAME.last_bought.pos = nil
    end

    if G.GAME.current_round.zombie_target and G.GAME.current_round.zombie_target.pos then
        G.GAME.current_round.zombie_target.card = G.jokers.cards[G.GAME.current_round.zombie_target.pos]
        G.GAME.current_round.zombie_target.pos = nil
    end

    local blockbusters = SMODS.find_card('j_mxms_blockbuster')
    if next(blockbusters) then
        for i = 1, #blockbusters do
            if blockbusters[i].ability.extra.pos then
                blockbusters[i].ability.extra.card = G.jokers.cards[blockbusters[i].ability.extra.pos]
                blockbusters[i].ability.extra.pos = nil
            end
        end
    end
end

local csc = Card.set_cost
function Card:set_cost()
    csc(self)
    self.cost = self.cost * G.GAME.shop_price_multiplier * G.GAME.creep_mod
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
--#endregion

--#region Misc Variables ------------------------------------------------------------------------------------
mxms_vanilla_food = {
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
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            -- Insert base game food jokers
            for k, _ in pairs(mxms_vanilla_food) do
                self:inject_card(G.P_CENTERS[k])
            end
        end
    }
end

zodiac_killer_pools = {
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
--#endregion

--#region Round Changing Variables --------------------------------------------------------------------------
function SMODS.current_mod.reset_game_globals(run_start)
    -- Impractical Joker
    if G.GAME.challenge == 'c_mxms_biggest_loser' then
        G.GAME.current_round.impractical_hand = 'Straight Flush'
    elseif G.GAME.round ~= 1 then
        G.GAME.current_round.impractical_hand = G.GAME.current_round.impractical_hand
        local valid_hands = {}

        for k, v in pairs(G.GAME.hands) do
            if v.visible then
                valid_hands[#valid_hands + 1] = k
            end
        end

        local new_hand = G.GAME.current_round.impractical_hand
        while new_hand == G.GAME.current_round.impractical_hand do
            new_hand = pseudorandom_element(valid_hands, pseudoseed('impractical' .. G.GAME.round_resets.ante))
        end
        G.GAME.current_round.impractical_hand = new_hand
    end

    -- Marco Polo
    if G.GAME.round ~= 1 then
        local new_pos = G.GAME.current_round.marco_polo_pos
        if #G.jokers.cards <= 1 then
            new_pos = 1
        else
            while new_pos == G.GAME.current_round.marco_polo_pos do
                new_pos = pseudorandom(pseudoseed('marcopolo' .. G.GAME.round_resets.ante), 1, #G.jokers.cards)
            end
        end
        G.GAME.current_round.marco_polo_pos = new_pos
    end

    -- Go Fish
    if G.GAME.round ~= 1 then
        local valid_ranks = {}
        local new_rank = G.GAME.current_round.go_fish.rank
        local new_mult = 0
        for k, v in ipairs(G.playing_cards) do
            valid_ranks[#valid_ranks + 1] = v.base.value
        end
        new_rank = pseudorandom_element(valid_ranks, pseudoseed('go_fish' .. G.GAME.round_resets.ante))
        G.GAME.current_round.go_fish.rank = new_rank
        for k, v in ipairs(valid_ranks) do
            if v == new_rank then
                new_mult = new_mult + 1
            end
        end
        G.GAME.current_round.go_fish.mult = new_mult * 2
    end

    -- Zombie
    if next(SMODS.find_card('j_mxms_zombie')) and G.GAME.current_round.zombie_target.card ~= nil then
        if not G.GAME.current_round.zombie_target.card.ability.eternal then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    delay(0.4)
                    G.GAME.current_round.zombie_target.card:set_ability(G.P_CENTERS['j_mxms_zombie'])
                    G.GAME.current_round.zombie_target.card:juice_up(0.8, 0.8)
                    delay(0.4)
                    SMODS.calculate_effect({ message = "Turned!", colour = G.C.GREEN },
                        G.GAME.current_round.zombie_target.card)
                    G.GAME.current_round.zombie_target.card = nil
                    return true
                end
            }))
        end
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
            local eligible_jokers = {}
            local new_target = G.GAME.current_round.zombie_target.card
            if #G.jokers.cards <= 1 or not next(SMODS.find_card('j_mxms_zombie')) then
                new_target = nil
            else
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].config.center.key ~= 'j_mxms_zombie' and G.jokers.cards[i] ~= new_target and G.jokers.cards[i].config.center.blueprint_compat then
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

            G.GAME.current_round.zombie_target.card = new_target
            if G.GAME.current_round.zombie_target.card ~= nil then
                SMODS.calculate_effect({ message = "Infected!", colour = G.C.GREEN },
                    G.GAME.current_round.zombie_target.card)
            end
            return true
        end
    }))


    -- Jello
    local jello_suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.ajello_suits then jello_suits[#jello_suits + 1] = v end
    end
    G.GAME.current_round.jello_suit = pseudorandom_element(jello_suits, pseudoseed('jel' .. G.GAME.round_resets.ante))
end

--#endregion

--#region Ownership Taking ----------------------------------------------------------------------------------

-- Make Editions scale with Power Creep
SMODS.Edition:take_ownership('polychrome', {
        loc_vars = function(self)
            return { vars = { self.config.x_mult * G.GAME.creep_mod } }
        end,
        calculate = function(self, card, context)
            if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    x_mult = card.edition.x_mult * G.GAME.creep_mod
                }
            end
        end
    },
    true)

SMODS.Edition:take_ownership('holo', {
        loc_vars = function(self)
            return { vars = { self.config.mult * G.GAME.creep_mod } }
        end,
        calculate = function(self, card, context)
            if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    mult = card.edition.mult * G.GAME.creep_mod
                }
            end
        end
    },
    true)

SMODS.Edition:take_ownership('foil', {
        loc_vars = function(self)
            return { vars = { self.config.chips * G.GAME.creep_mod } }
        end,
        calculate = function(self, card, context)
            if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    chips = card.edition.chips * G.GAME.creep_mod
                }
            end
        end
    },
    true)


-- Change 4oaK and 2P to work with Fog
SMODS.PokerHand:take_ownership('Four of a Kind', {
        evaluate = function(parts, hand)
            if #parts._2 == 2 and next(SMODS.find_card('j_mxms_fog')) then
                local pair_1 = parts._2[1]
                local pair_2 = parts._2[2]
                if math.abs(pair_1[1]:get_id() - pair_2[2]:get_id()) == 1 or (pair_1[1]:get_id() == 14 and pair_2[1]:get_id() == 2) then
                    return parts._all_pairs
                end
            end
            return parts._4
        end
    },
    true)

SMODS.PokerHand:take_ownership('Two Pair', {
        evaluate = function(parts, hand)
            if next(parts._4) and next(SMODS.find_card('j_mxms_fog')) then return parts._4 end
            if #parts._2 < 2 then return {} end
            return parts._all_pairs
        end
    },
    true)

-- Change Full House to not interfere with Perspective
SMODS.PokerHand:take_ownership('Full House', {
        evaluate = function(parts, hand)
            if #parts._3 < 1 or #parts._2 < 2 or #hand < 5 then return {} end
            return parts._all_pairs
        end
    },
    true)

-- Change Arcana Packs to include checks for Sharp Suit
SMODS.Booster:take_ownership_by_kind('Arcana', {
        create_card = function(self, card, i)
            local _card
            if G.GAME.used_vouchers.v_mxms_sharp_suit and i == 1 then
                local suit_tallies = { ['Spades'] = 0, ['Hearts'] = 0, ['Clubs'] = 0, ['Diamonds'] = 0 }
                for k, v in ipairs(G.playing_cards) do
                    suit_tallies[v.base.suit] = (suit_tallies[v.base.suit] or 0) + 1
                end
                local _tarot, _suit, _tally = nil, nil, 0
                for k, v in pairs(suit_tallies) do
                    if v > _tally then
                        _suit = k
                        _tally = v
                    end
                end
                if _suit then
                    for k, v in pairs(G.P_CENTER_POOLS.Tarot) do
                        if v.config.suit_conv == _suit then
                            _tarot = v.key
                        end
                    end
                end
                _card = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key = _tarot,
                    key_append =
                    'ar1'
                }
            elseif G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
                _card = {
                    set = "Spectral",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar2"
                }
            else
                _card = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar1"
                }
            end
            return _card
        end
    },
    true)

-- Change Ankh and Hex to work with Shield and Guardian Vouchers
SMODS.Consumable:take_ownership('ankh', {
        config = {
            extra = {
                chance = 2,
                odds = 2,
            }
        },
        loc_vars = function(self, info_queue, center)
            return { vars = { center.ability.extra.chance - G.GAME.v_destroy_reduction, center.ability.extra.odds } }
        end,
        use = function(self, card, area, copier)
            local deletable_jokers = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
            end
            local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('ankh_choice'))
            local _first_dissolve = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    for k, v in pairs(deletable_jokers) do
                        if v ~= chosen_joker then
                            if pseudorandom('ankh') < (card.ability.extra.chance - G.GAME.v_destroy_reduction) / card.ability.extra.odds then
                                v:start_dissolve(nil, _first_dissolve)
                                _first_dissolve = true
                            elseif not G.GAME.used_vouchers.v_mxms_guardian then
                                card_eval_status_text(v, 'extra', nil, nil, nil, { message = localize('k_safe_ex') })
                            end
                        end
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.4,
                func = function()
                    local card = copy_card(chosen_joker, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                    card:start_materialize()
                    card:add_to_deck()
                    if card.edition and card.edition.negative then
                        card:set_edition(nil, true)
                    end
                    G.jokers:emplace(card)
                    return true
                end
            }))
        end
    },
    true)

SMODS.Consumable:take_ownership('hex', {
        config = {
            extra = {
                chance = 2,
                odds = 2,
            }
        },
        loc_vars = function(self, info_queue, center)
            return { vars = { center.ability.extra.chance - G.GAME.v_destroy_reduction, center.ability.extra.odds } }
        end,
        use = function(self, card, area, copier)
            local temp_pool = card.eligible_editionless_jokers or {}
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local over = false
                    local eligible_card = pseudorandom_element(temp_pool, pseudoseed('hex'))
                    local edition = { polychrome = true }
                    eligible_card:set_edition(edition, true)
                    check_for_unlock({ type = 'have_edition' })
                    local _first_dissolve = nil
                    for k, v in pairs(G.jokers.cards) do
                        if v ~= eligible_card and (not v.ability.eternal) then
                            if pseudorandom('hex') < (card.ability.extra.chance - G.GAME.v_destroy_reduction) / card.ability.extra.odds then
                                v:start_dissolve(nil, _first_dissolve); _first_dissolve = true
                            elseif not G.GAME.used_vouchers.v_mxms_guardian then
                                card_eval_status_text(v, 'extra', nil, nil, nil, { message = localize('k_safe_ex') })
                            end
                        end
                    end
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
    },
    true)

SMODS.Joker:take_ownership('j_cavendish', {
        remove_from_deck = function(self, args)
            G.GAME.pool_flags.cavendish_removed = true
        end
    },
    true)

--#endregion

--#region Helper Functions ----------------------------------------------------------------------------------

function reset_horoscopes()
    if G.GAME.aries_bonus then
        G.GAME.aries_bonus = false
    end

    if G.GAME.cancer_bonus then
        G.GAME.cancer_bonus = false
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 2
        ease_hands_played(-2)
    end

    if G.GAME.leo_bonus then
        G.GAME.leo_bonus = false
        G.hand:change_size(-3)
    end

    if G.GAME.virgo_bonus then
        G.GAME.virgo_bonus = false
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 3
        ease_discard(-3)
    end
end

function apply_horoscope_effects()
    if G.GAME.next_ante_horoscopes["Aries"] then
        G.GAME.aries_bonus = true
        G.GAME.next_ante_horoscopes["Aries"] = false
    end
    if G.GAME.next_ante_horoscopes["Cancer"] then
        G.GAME.cancer_bonus = true
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
        ease_hands_played(2)
        G.GAME.next_ante_horoscopes["Cancer"] = false
    end
    if G.GAME.next_ante_horoscopes["Leo"] then
        G.GAME.leo_bonus = true
        G.hand:change_size(3)
        G.GAME.next_ante_horoscopes["Leo"] = false
    end
    if G.GAME.next_ante_horoscopes["Virgo"] then
        G.GAME.virgo_bonus = true
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 3
        ease_discard(3)
        G.GAME.next_ante_horoscopes["Virgo"] = false
    end
end

---Checks if a provided card is classified as a "Food Joker"
function mxms_is_food(card)
    local center = type(card) == "string"
        and G.P_CENTERS[card]
        or (card.config and card.config.center)

    if not center then
        return false
    end

    -- If the center has the Food pool in its definition
    if center.pools and center.pools.Food then
        return true
    end

    -- If it doesn't, we check if this is a vanilla food joker
    return mxms_vanilla_food[center.key]
end

--Code from Betmma's Vouchers
G.FUNCS.can_pick_card = function(e)
    if #G.mxms_horoscope.cards < G.mxms_horoscope.config.card_limit then
        e.config.colour = G.C.GREEN
        e.config.button = 'pick_card'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.pick_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            c1.area:remove_card(c1)
            c1:add_to_deck()
            if c1.children.price then c1.children.price:remove() end
            c1.children.price = nil
            if c1.children.buy_button then c1.children.buy_button:remove() end
            c1.children.buy_button = nil
            remove_nils(c1.children)
            G.consumeables:emplace(c1)
            G.GAME.pack_choices = G.GAME.pack_choices - 1
            if G.GAME.pack_choices <= 0 then
                G.FUNCS.end_consumeable(nil, delay_fac)
            end
            return true
        end
    }))
end

--#endregion

--#region Horoscope -----------------------------------------------------------------------------------------

-- Horoscope Type
if Maximus_config.horoscopes then
    SMODS.ConsumableType {
        key = 'Horoscope',
        primary_colour = G.C.SET.Horoscope,
        secondary_colour = G.C.SECONDARY_SET.Horoscope,
        default = 'c_mxms_taurus',
        loc_txt = {
            name = 'Horoscope',
            collection = 'Horoscope Cards',
            undiscovered = {
                name = 'Not Discovered',
                text = { "Purchase this",
                    "card in an",
                    "unseeded run to",
                    "learn what it does", },
            },
        },
        collection_rows = { 3, 3 },
        shop_rate = 0.0
    }

    -- CardArea emplace hook
    local cae = CardArea.emplace
    function CardArea:emplace(card, location, stay_flipped)
        if self == G.consumeables and (card.ability.set == "Horoscope" or card.config.center.key == 'c_mxms_ophiucus') then
            G.mxms_horoscope:emplace(card, location, stay_flipped)
            return
        end

        cae(self, card, location, stay_flipped)
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
        local status, err = pcall(function()
            return NFS.load(SMODS.current_mod.path .. 'items/horoscopes/' .. ENABLED_HOROSCOPES[i] .. '.lua')()
        end)
        sendDebugMessage("Loaded horoscope: " .. ENABLED_HOROSCOPES[i], 'Maximus')

        if not status then
            error(ENABLED_HOROSCOPES[i] .. ": " .. err)
        end
    end
    sendDebugMessage("", 'Maximus')
end
--#endregion

--#region Boosters

local ENABLED_BOOSTERS = {
    'horoscope_normal_1',
    'horoscope_normal_2',
    'horoscope_jumbo_1',
    'horoscope_mega_1',
}

if Maximus_config.horoscopes then
    sendDebugMessage("Loading Boosters...", 'Maximus')
    for i = 1, #ENABLED_BOOSTERS do
        local status, err = pcall(function()
            return NFS.load(SMODS.current_mod.path .. 'items/boosters/' .. ENABLED_BOOSTERS[i] .. '.lua')()
        end)
        sendDebugMessage("Loaded booster: " .. ENABLED_BOOSTERS[i], 'Maximus')

        if not status then
            error(ENABLED_BOOSTERS[i] .. ": " .. err)
        end
    end
else
    sendDebugMessage("Horoscopes disabled; Skipping Boosters...", 'Maximus')
end
sendDebugMessage("", 'Maximus')


--#endregion

--#region Jokers --------------------------------------------------------------------------------------------

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
    'wild_buddy',
    'bones_jr',

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
    'dont_mind_if_i_do',
    'poet',
    'gravity',
    'fog',
    'rock_slide',
    'game_review',
    'slippery_slope',
    'celestial_deity',
    'high_dive',
    'brainwashed',
    'whos_on_first',

    --Rare
    'abyss',
    'combo_breaker',
    'joker+',
    'streaker',
    'jobber',
    'astigmatism',
    'dark_room',
    'guillotine',
    'soil',
    'stop_sign',
    'chihuahua',
    'vulture',
    'prince',

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

    --Thought Experiments
    'occam',
    'schrodinger',
    'chekhov',

    --God Cards
    'slifer',
    'obelisk',

    --Metamorphosis Trio

    --Shoppers
    'coupon',
    'monk',
    'sleuth',
    'hedonist',
    'power_creep',

    --Moneymakers
    'gambler',
    'hypeman',
    'fools_gold',
    'jackpot',

    --Horoscope Jokers
    'hippie',
    'cheat_day',
    'letter',
    'employee',

    --Legendaries
    'ledger',
    'galifianakis',
}

local EXPERIMENTAL_JOKERS = {
    'golden_rings',
    'caterpillar',
    'chrysalis',
    'butterfly',
    'conveyor_belt',
    'abyss_angel',
    'god_hand',
    'sisyphus',
    'nomai',
    'rock_candy',
    'blockbuster',

    'romero',
    'leto',
    'nicholson',
    'phoenix',
    'hamill',
}

sendDebugMessage("Loading Jokers...", 'Maximus')
for i = 1, #ENABLED_JOKERS do
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/jokers/' .. ENABLED_JOKERS[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded joker: " .. ENABLED_JOKERS[i], 'Maximus')

    if not status then
        error(ENABLED_JOKERS[i] .. ": " .. err)
    end
end
sendDebugMessage("", 'Maximus')

if Maximus_config.experimental_features then
    sendDebugMessage("Loading Experimental Jokers...", 'Maximus')
    for i = 1, #EXPERIMENTAL_JOKERS do
        local status, err = pcall(function()
            return NFS.load(SMODS.current_mod.path .. 'items/jokers/' .. EXPERIMENTAL_JOKERS[i] .. '.lua')()
        end)
        sendDebugMessage("Loaded joker: " .. EXPERIMENTAL_JOKERS[i], 'Maximus')

        if not status then
            error(EXPERIMENTAL_JOKERS[i] .. ": " .. err)
        end
    end
else
    sendDebugMessage("Experimental Features disabled; Skipping Experimental Jokers...", 'Maximus')
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Vouchers ------------------------------------------------------------------------------------------

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
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/vouchers/' .. ENABLED_VOUCHERS[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded voucher: " .. ENABLED_VOUCHERS[i], 'Maximus')

    if not status then
        error(ENABLED_VOUCHERS[i] .. ": " .. err)
    end
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
}

sendDebugMessage("Loading Challenges...", 'Maximus')
for i = 1, #ENABLED_CHALLENGES do
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/challenges/' .. ENABLED_CHALLENGES[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded challenge: " .. ENABLED_CHALLENGES[i], 'Maximus')

    if not status then
        error(ENABLED_CHALLENGES[i] .. ": " .. err)
    end
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Backs ---------------------------------------------------------------------------------------------

local ENABLED_BACKS = {
    'sixth_finger',
    'nirvana',
    'nuclear',
    'professional',
    'grilled',
    'autographed',
}

sendDebugMessage("Loading Backs...", 'Maximus')
for i = 1, #ENABLED_BACKS do
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/backs/' .. ENABLED_BACKS[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded deck: " .. ENABLED_BACKS[i], 'Maximus')

    if not status then
        error(ENABLED_BACKS[i] .. ": " .. err)
    end
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Hand Parts ----------------------------------------------------------------------------------------

local ENABLED_HAND_PARTS = {
    '_6',
    's_flush',
    's_straight'
}

sendDebugMessage("Loading Hand Parts...", 'Maximus')
for i = 1, #ENABLED_HAND_PARTS do
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/handtypes/parts/' .. ENABLED_HAND_PARTS[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded hand part: " .. ENABLED_HAND_PARTS[i], 'Maximus')

    if not status then
        error(ENABLED_HAND_PARTS[i] .. ": " .. err)
    end
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Hand Types ----------------------------------------------------------------------------------------

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
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/handtypes/' .. ENABLED_HANDS[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded hand type: " .. ENABLED_HANDS[i], 'Maximus')

    if not status then
        error(ENABLED_HANDS[i] .. ": " .. err)
    end
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Consumables ---------------------------------------------------------------------------------------

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
}

sendDebugMessage("Loading Consumables...", 'Maximus')
for i = 1, #ENABLED_CONSUMABLES do
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/consumables/' .. ENABLED_CONSUMABLES[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded consumable: " .. ENABLED_CONSUMABLES[i], 'Maximus')

    if not status then
        error(ENABLED_CONSUMABLES[i] .. ": " .. err)
    end
end

sendDebugMessage("", 'Maximus')

--#endregion

--#region Blinds --------------------------------------------------------------------------------------------

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
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/blinds/' .. ENABLED_BLINDS[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded blind: " .. ENABLED_BLINDS[i], 'Maximus')

    if not status then
        error(ENABLED_BLINDS[i] .. ": " .. err)
    end
end
sendDebugMessage("", 'Maximus')

--#endregion

--#region Tags ----------------------------------------------------------------------------------------------

local ENABLED_TAGS = {
    'star',
}
sendDebugMessage("Loading Tags...", 'Maximus')
for i = 1, #ENABLED_TAGS do
    local status, err = pcall(function()
        return NFS.load(SMODS.current_mod.path .. 'items/tags/' .. ENABLED_TAGS[i] .. '.lua')()
    end)
    sendDebugMessage("Loaded tag: " .. ENABLED_TAGS[i], 'Maximus')

    if not status then
        error(ENABLED_TAGS[i] .. ": " .. err)
    end
end
sendDebugMessage("", 'Maximus')


--#endregion
