-- Load config
Maximus_config = SMODS.current_mod.config

--region SMODS Optional Features
SMODS.current_mod.optional_features = { retrigger_joker = true }
--endregion

--region Atlases
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

SMODS.Atlas { -- Main Blind Atlas
    key = 'Blinds',
    path = "Blinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

--endregion

--region Function Hooks
local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)

    -- Conditional/tracking Modifiers
    ret.choose_mod = 0
    ret.war_mod = 1
    ret.fridge_mod = 1
    ret.soy_mod = 1
    ret.purchased_jokers = {}
    ret.gambler_mod = 1
    ret.spectrals_used = 0
    ret.creep_mod = 1
    ret.soil_mod = 1
    ret.skip_tag = ''
    ret.last_bought = nil
    ret.v_destroy_reduction = 0
    ret.shop_price_multiplier = 1

    --Rotating Modifiers
    ret.current_round.impractical_hand = 'Straight Flush'
    ret.current_round.marco_polo_pos = 1
    ret.current_round.go_fish = {
        rank = "Ace",
        mult = 8
    }
    ret.current_round.zombie_target = nil

    return ret
end

-- Get Chip Mult hook for perma mult
local cgcm = Card.get_chip_mult
function Card.get_chip_mult(self)
    local ret = cgcm(self)
    if not self.debuff and not (self.ability.set == "Joker") then
        if self.ability.mxms_mult_perma_bonus then
            ret = ret + self.ability.mxms_mult_perma_bonus
        end
    end
    return ret
end

-- Repetition Calc hook for Combo Breaker card repetition tracking
local rep_calc = SMODS.calculate_repetitions
function SMODS.calculate_repetitions(card, context, reps)
    local rep_return = rep_calc(card, context, reps)
    local jokers = SMODS.find_card('j_mxms_combo_breaker')
    if next(jokers) then
        for _, joker in ipairs(jokers) do
            joker.ability.extra.retriggers = joker.ability.extra.retriggers + #rep_return - 1
        end
    end
    return rep_return
end

-- Set Ability hook for H&C and Hype Man
local csa = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    csa(self, center, initial, delay_sprites)
    -- Hammer and Chisel
    if center == G.P_CENTERS.m_stone and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
        self.config.center.replace_base_card = false
        self.config.center.no_rank = false
        self.config.center.no_suit = false
    end
    -- Hype Man
    if center.set == "Enhanced" and G.STATE ~= G.STATES.STANDARD_PACK and not G.SETTINGS.paused then
        local hypes = SMODS.find_card('j_mxms_hypeman')
        if next(hypes) then
            for k, v in ipairs(hypes) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mxms_hey')
                        return true;
                    end
                }))
                card_eval_status_text(v, 'extra', nil, nil, nil,
                    { message = '+' .. v.ability.extra.dollars, colour = G.C.MONEY })
                ease_dollars(v.ability.extra.dollars)
            end
        end
    end
end

--endregion

--region Sounds
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
--endregion

--region Misc Variables
food_jokers = { {
    key = 'j_gros_michel',
    name = 'Gros Michel'
}, {
    key = 'j_egg',
    name = 'Egg'
}, {
    key = 'j_ice_cream',
    name = 'Ice Cream'
}, {
    key = 'j_cavendish',
    name = 'Cavendish'
}, {
    key = 'j_turtle_bean',
    name = 'Turtle Bean'
}, {
    key = 'j_diet_cola',
    name = 'Diet Cola'
}, {
    key = 'j_popcorn',
    name = 'Popcorn'
}, {
    key = 'j_ramen',
    name = 'Ramen'
}, {
    key = 'j_selzer',
    name = 'Seltzer'
}, {
    key = 'j_mxms_fortune_cookie',
    name = 'Fortune Cookie'
}, {
    key = 'j_mxms_leftovers',
    name = 'Leftovers'
}, {
    key = 'j_mxms_breadsticks',
    name = 'Endless Breadsticks'
}, {
    key = 'j_mxms_four_course_meal',
    name = 'Four Course Meal'
} }
--endregion

--region Round Changing Variables
function SMODS.current_mod.reset_game_globals(run_start)
    -- Impractical Joker
    if G.GAME.challenge == 'c_mxms_biggest_loser' then
        G.GAME.current_round.impractical_hand = 'Straight Flush'
    elseif not next(SMODS.find_card('j_mxms_stop_sign')) and G.GAME.round ~= 1 then
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
    if not next(SMODS.find_card('j_mxms_stop_sign')) and G.GAME.round ~= 1 then
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
    if not next(SMODS.find_card('j_mxms_stop_sign')) and G.GAME.round ~= 1 then
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
    if next(SMODS.find_card('j_mxms_zombie')) and G.GAME.current_round.zombie_target ~= nil then
        if not G.GAME.current_round.zombie_target.ability.eternal then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    delay(0.4)
                    G.GAME.current_round.zombie_target:start_dissolve({ G.C.GREEN }, nil, 1.6)
                    local new_zombie = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mxms_zombie',
                        'zombie')
                    new_zombie:start_materialize()
                    new_zombie:add_to_deck()
                    G.jokers:emplace(new_zombie)
                    delay(0.4)
                    card_eval_status_text(new_zombie, 'extra', nil, nil, nil, { message = 'Turned!', colour = G.C.GREEN })
                    return true
                end
            }))
        end
    end

    if not next(SMODS.find_card('j_mxms_stop_sign')) then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                local eligible_jokers = {}
                local new_target = G.GAME.current_round.zombie_target
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

                G.GAME.current_round.zombie_target = new_target
                if G.GAME.current_round.zombie_target ~= nil then
                    card_eval_status_text(G.GAME.current_round.zombie_target, 'extra', nil, nil, nil,
                        { message = 'Infected!', colour = G.C.GREEN })
                end
                return true
            end
        }))
    end
end

--endregion

--region Ownership Taking

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

--endregion

--region Update Checks

local upd = Game.update

mxms_4d_dt_anim = 0
mxms_4d_dt_mod = 0

function Game:update(dt)
    upd(self, dt)

    mxms_4d_dt_anim = mxms_4d_dt_anim + dt
    if next(SMODS.find_card('j_mxms_4d')) and not G.SETTINGS.paused then
        mxms_4d_dt_mod = mxms_4d_dt_mod + dt
    end

    -- 4D Patches (Derived from Jimball animation code)
    if G.P_CENTERS and G.P_CENTERS.j_mxms_4d and mxms_4d_dt_anim > 0.05 then
        mxms_4d_dt_anim = 0

        local obj = G.P_CENTERS.j_mxms_4d

        if obj.pos.x == 0 and obj.pos.y == 7 then
            obj.pos.x = 0
            obj.pos.y = 0
        elseif obj.pos.x < 9 then
            obj.pos.x = obj.pos.x + 1
        elseif obj.pos.y < 7 then
            obj.pos.x = 0
            obj.pos.y = obj.pos.y + 1
        end
    end
    if next(SMODS.find_card('j_mxms_4d')) and mxms_4d_dt_mod > 1 then
        mxms_4d_dt_mod = 0

        for k, v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_mxms_4d' and v.ability.extra.Xmult > 1 then
                v.ability.extra.Xmult = v.ability.extra.Xmult - 0.01
                v:juice_up(0.1, 0.2)
                if Maximus_config.Maximus.four_d_ticks then
                    play_sound('generic1')
                end
            end
        end
    end
end

--endregion

--region Jokers
SMODS.Joker { -- Fortune Cookie
    key = 'fortune_cookie',
    loc_txt = {
        name = 'Fortune Cookie',
        text = { '{C:green}#3# out of #4#{} chance to receive', 'a random {C:tarot}Tarot{} card when',
            ' playing a hand {C:inactive}(Must have room){}',
            '{C:inactive}Chance reduces by #1# for every played hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    perishable_compat = false,
    eternal_compat = false,
    blueprint_compat = true,
    cost = 4,
    config = {
        extra = {
            chance = 10,
            odds = 10
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.probabilities.normal, center.ability.extra.chance * G.GAME.fridge_mod,
                center.ability.extra.chance * G.GAME.fridge_mod * G.GAME.probabilities.normal,
                center.ability.extra.odds * G.GAME.fridge_mod }
        }
    end,
    calculate = function(self, card, context)
        -- Activate ability before scoring if chance is higher than 0
        if context.before and card.ability.extra.chance > 0 then
            -- Roll chance and decrease by 1
            local chance_roll = pseudorandom(pseudoseed('fco' .. G.GAME.round_resets.ante), 1,
                10 * G.GAME.fridge_mod * G.GAME.probabilities.normal)
            local chance_odds = (card.ability.extra.odds - card.ability.extra.chance) * G.GAME.fridge_mod
            card.ability.extra.chance = card.ability.extra.chance - (1 / G.GAME.fridge_mod)

            -- Check if Consumables is full
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                -- Successful roll
                if (chance_roll >= chance_odds) then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            play_sound('tarot1')
                            card:juice_up(0.3, 0.4)

                            local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'fco')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true;
                        end
                    }))
                    return {
                        card = card,
                        message = 'FORTUNATE!',
                        colour = G.C.SECONDARY_SET.Tarot
                    }

                    -- Failed Roll
                else
                    local pessimistics = SMODS.find_card('j_mxms_pessimistic')
                    if next(pessimistics) then
                        for k, v in pairs(pessimistics) do
                            v.ability.extra.mult = v.ability.extra.mult +
                                (card.ability.extra.odds - card.ability.extra.chance * G.GAME.probabilities.normal) *
                                G.GAME.soil_mod
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                func = function()
                                    v:juice_up(0.3, 0.4)
                                    local groupchats = SMODS.find_card('j_mxms_group_chat')
                                    if next(groupchats) then
                                        for k, v in pairs(groupchats) do
                                            v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                                            v:juice_up(0.3, 0.4)
                                        end
                                    end
                                    return true;
                                end
                            }))
                        end
                    end

                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            play_sound('tarot2')
                            return true;
                        end
                    }))
                    return {
                        card = card,
                        message = localize('k_nope_ex'),
                        colour = G.C.SET.Tarot
                    }
                end
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        play_sound('tarot2')
                        return true;
                    end
                }))
                return {
                    card = card,
                    message = 'WASTED',
                    colour = G.C.SET.Tarot
                }
            end

            card:juice_up(0.3, 0.4)
            return {
                card = card,
                message = '-1',
                colour = G.C.RED
            }
        end

        -- "Crumble" card after scoring
        if context.after and not context.blueprint then
            if card.ability.extra.chance <= 0 then
                G.GAME.destroyed_food = card.config.center.key
                -- Code derived from Gros Michel/Cavendish
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    card = card,
                    message = 'Crumbled'
                }
            end
        end
    end
}

SMODS.Joker { -- Poindexter
    key = 'poindexter',
    loc_txt = {
        name = "Poindexter",
        text = { '{X:mult,C:white}X0.25{} Mult for every', 'scoring {C:attention}glass card{} that',
            'remains intact; {C:red}Resets{} on break', '{C:inactive}Currently: {X:mult,C:white}X#1#{}' }
    },
    atlas = 'Jokers',
    rarity = 2,
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            Xmult = 1.0,
            shattered = false
        }
    },
    blueprint_compat = true,
    cost = 7,
    enhancement_gate = 'm_glass',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {
            vars = { center.ability.extra.Xmult, center.ability.extra.shattered }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end

        if context.before and not context.blueprint then
            card.ability.extra.shattered = false
        end

        if context.remove_playing_cards and not context.blueprint then
            -- Check for shattered glass
            if context.removed ~= nil then
                for k, v in ipairs(context.removed) do
                    if v.config.center_key == 'm_glass' and not v.debuff then
                        card.ability.extra.Xmult = 1
                        card.ability.extra.shattered = true
                    end
                    if shattered then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                play_sound('tarot2')
                                card:juice_up(0.3, 0.4)
                                return true;
                            end
                        }))
                    end
                end
            end
        end

        if context.after and not context.blueprint then
            if card.ability.extra.shattered then
                return {
                    card = card,
                    message = 'Errrrmmm...',
                    colour = G.C.RED
                }
            else
                -- If no shattered glass, add to mult
                local glass = 0
                for k, val in ipairs(context.scoring_hand) do
                    if val.config.center_key == 'm_glass' then
                        glass = glass + 1
                    end
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        card.ability.extra.Xmult = card.ability.extra.Xmult + ((glass * 0.25) * G.GAME.soil_mod)
                        local groupchats = SMODS.find_card('j_mxms_group_chat')
                        if next(groupchats) then
                            for k, v in pairs(groupchats) do
                                v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                                v:juice_up(0.3, 0.4)
                            end
                        end
                        card:juice_up(0.3, 0.4)
                        play_sound('tarot1')
                        return true;
                    end
                }))
                return {
                    card = card,
                    message = 'Eureka!',
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker { -- Abyss
    key = 'abyss',
    loc_txt = {
        name = "Abyss",
        text = { 'When blind is selected, {C:green}50/50{}', '{C:attention}chance{} of making a currently held',
            'non-negative Joker {C:dark_edition}Negative{} or', 'destroying a currently held non-negative joker',
            '{C:inactive}Can override other editions{}' }
    },
    atlas = 'Jokers',
    rarity = 3,
    pos = {
        x = 2,
        y = 0
    },
    config = {},
    blueprint_compat = true,
    cost = 9,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            -- Store all eligible jokers in table
            -- Code derived Madness
            local eligible_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and
                    not (G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative) and
                    not G.jokers.cards[i].getting_sliced then
                    eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                end
            end

            -- Fail if no held jokers are eligible
            if next(eligible_jokers) == nil then
                return {
                    extra = {
                        message = 'No target...',
                        colour = G.C.PURPLE
                    },
                    card = card
                }
            else
                -- Choose Joker to affect
                local chosen_joker =
                    #eligible_jokers > 0 and
                    pseudorandom_element(eligible_jokers, pseudoseed('abyss' .. G.GAME.round_resets.ante)) or nil

                -- "Flip a coin" to decide what to do with the target
                local flip = pseudorandom(pseudoseed('aby' .. G.GAME.round_resets.ante), 1, 2)

                -- Add negative edition to random held joker
                if flip == 1 and chosen_joker ~= nil then
                    card:juice_up(0.3, 0.4)
                    chosen_joker:set_edition({
                        negative = true
                    }, true)
                    return {
                        extra = {
                            message = 'Void-touched!',
                            colour = G.C.PURPLE
                        },
                        card = card
                    }

                    -- Destroy a random non-negative joker
                elseif flip == 2 then
                    -- Double check the target is not self
                    -- Code derived Madness
                    if chosen_joker and not (context.blueprint_card or card).getting_sliced then
                        chosen_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                chosen_joker:start_dissolve({ G.C.PURPLE }, nil, 1.6)
                                return true;
                            end
                        }))
                    end
                    return {
                        extra = {
                            message = 'Consumed',
                            colour = G.C.PURPLE
                        },
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- War
    key = 'war',
    loc_txt = {
        name = 'War',
        text = { 'Means of destroying cards', 'have their limits {C:attention}doubled{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 2,
    config = {},
    blueprint_compat = false,
    cost = 8,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.war_mod = G.GAME.war_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.war_mod = G.GAME.war_mod / 2
    end
}

SMODS.Joker { -- Microwave
    key = 'microwave',
    loc_txt = {
        name = 'Microwave',
        text = { '{C:red}Food{} Jokers are', '{C:attention}retriggered' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 0
    },
    rarity = 2,
    config = {},
    blueprint_compat = true,
    eternal_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        -- Thank you to theonegoodali from the Balatro Discord for helping me with this conditional
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.ability then
            for i = 1, #food_jokers do
                if context.other_card.config.center.key == food_jokers[i].key and food_jokers[i].name ~= 'Leftovers' then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Combo Breaker
    key = 'combo_breaker',
    loc_txt = {
        name = 'Combo Breaker',
        text = { 'Gains {X:mult,C:white}X0.5{} Mult', 'per retrigger',
            '{C:inactive}Starts at {X:mult,C:white}X1{C:inactive} Mult, resets every hand{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 1
    },
    rarity = 3,
    config = {
        extra = {
            Xmult = 1.0,
            retriggers = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.Xmult, center.ability.extra.retriggers }
        }
    end,

    calculate = function(self, card, context)
        if context.post_trigger and context.other_context.retrigger_joker then
            -- Add retrigger to total
            card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            return {
                card = card
            }
        end

        if context.joker_main and card.ability.extra.retriggers > 0 then
            -- Add retrigger count and multiply by 0.5 for mult
            card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.retriggers * 0.5)

            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('mxms_perfect')
                    return true;
                end
            }))

            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before or context.after then
            card.ability.extra.retriggers = 0
            card.ability.extra.Xmult = 1.0
        end
    end
}

SMODS.Joker { -- Faded
    key = 'faded',
    loc_txt = {
        name = 'Faded Joker',
        text = { '{C:diamonds}Diamonds{} and {C:spades}Spades{}', 'count as the same suit,',
            '{C:hearts}Hearts{} and {C:clubs}Clubs{}', 'count as the same suit' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 1
    },
    rarity = 2,
    config = {},
    blueprint_compat = false,
    cost = 7,
}

SMODS.Joker { -- Old Man Jimbo
    key = 'old_man_jimbo',
    loc_txt = {
        name = 'Old Man Jimbo',
        text = { '{X:mult,C:white}X1{} Mult plus {X:mult,C:white}X0.5{}', 'for each remaining hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 0
        }
    },
    blueprint_compat = true,
    cost = 6,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.Xmult = 1 + (0.5 * G.GAME.current_round.hands_left)
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Joker+
    key = 'joker_plus',
    loc_txt = {
        name = 'Joker+',
        text = { '{C:mult}+5{} Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 1
    },
    rarity = 3,
    config = {
        extra = {
            mult = 5
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Normal Joker
    key = 'normal',
    loc_txt = {
        name = 'Normal Joker',
        text = { 'Played cards without an', 'enchancement, edition, or seal',
            ' give {C:mult}+2{} Mult and {C:chips}+15{} Chips' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 1
    },
    rarity = 1,
    config = {},
    blueprint_compat = true,
    cost = 3,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.other_card.edition and not context.other_card.seal and not next(SMODS.get_enhancements(context.other_card)) then
                return {
                    mult = 2,
                    chips = 15,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker { -- Streaker
    key = 'streaker',
    loc_txt = {
        name = 'Streaker',
        text = { '{C:chips}+20{} Chips and {C:mult}+5{} Mult', 'for each consecutive {C:attention}blind{}',
            'beaten in {C:attention}one hand{}, {C:red}Resets{}', 'when streak is broken',
            '{C:inactive}Current streak: #1#',
            '{C:inactive}Currently: {C:chips}+#3# {C:inactive}Chips, {C:mult}+#4#{} Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            streak = 0,
            hands = 0, -- I know there's an tracker in vanilla but I can't access it at context.end_of_round
            chips = 0,
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.streak, center.ability.extra.hands, center.ability.extra.chips,
                center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.streak > 0 then
            return {
                mult_mod = card.ability.extra.chips,
                chip_mod = card.ability.extra.mult,
                message = 'Streaked!',
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before and not context.blueprint then
            card.ability.extra.hands = card.ability.extra.hands + 1
            if card.ability.extra.hands > 1 and card.ability.extra.streak ~= 0 then
                card.ability.extra.streak = 0
                card.ability.extra.chips = 0
                card.ability.extra.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if card.ability.extra.hands == 1 then
                card.ability.extra.hands = 0
                card.ability.extra.streak = card.ability.extra.streak + 1
                card.ability.extra.chips = 20 * card.ability.extra.streak * G.GAME.soil_mod
                card.ability.extra.mult = 5 * card.ability.extra.streak * G.GAME.soil_mod
                local groupchats = SMODS.find_card('j_mxms_group_chat')
                if next(groupchats) then
                    for k, v in pairs(groupchats) do
                        v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                        v:juice_up(0.3, 0.4)
                    end
                end
                return {
                    message = 'Streak ' .. card.ability.extra.streak,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                card.ability.extra.hands = 0
            end
        end
    end
}

SMODS.Joker { -- Jobber
    key = 'jobber',
    loc_txt = {
        name = 'Jobber',
        text = { 'If hand is played with only', '{C:red}debuffed{} cards, destroy this',
            'Joker and create a random copy', 'of another held Joker', '{C:inactive}Removes negative from copy' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 0
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            -- Check if played hand is all debuffed cards
            local all_debuffed = true
            for i = 1, #context.scoring_hand do
                if not context.scoring_hand[i].debuff then
                    all_debuffed = false
                    break
                end
            end

            -- Fail if not all debuffed
            if not all_debuffed then
                return
            else
                -- Store all eligible jokers in table
                -- Code derived Madness
                local eligible_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card then
                        eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                    end
                end

                -- Fail if no held jokers are eligible
                if next(eligible_jokers) == nil then
                    return {
                        extra = {
                            message = 'No target...',
                            colour = G.C.PURPLE
                        },
                        card = card
                    }
                else
                    -- Destroy Jobber
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve({ G.C.YELLOW }, nil, 1.6)
                            return true;
                        end
                    }))
                end

                -- Choose Joker to copy
                local chosen_joker = #eligible_jokers > 0 and
                    pseudorandom_element(eligible_jokers, pseudoseed('jobber' .. G.GAME.round_resets.ante)) or nil

                -- Copy Joker and add to hand
                if chosen_joker ~= nil then
                    local new_card = copy_card(chosen_joker, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                    new_card:start_materialize()
                    new_card:add_to_deck()
                    if new_card.edition and new_card.edition.negative then
                        new_card:set_edition(nil, true)
                    end
                    G.jokers:emplace(new_card)
                    return {
                        extra = {
                            message = 'Jobbed',
                            colour = G.C.YELLOW
                        },
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Astigmatism
    key = 'astigmatism',
    loc_txt = {
        name = 'Astigmatism',
        text = { '{X:chips,C:white}x2{} Chips' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 0
    }, -- Change once sprite art is added
    rarity = 3,
    config = {},
    blueprint_compat = true,
    cost = 9,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = hand_chips,
                message = 'x2',
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Perspective
    key = 'perspective',
    loc_txt = {
        name = 'Perspective',
        text = { '{C:attention}6\'s{} are treated as {C:attention}9\'s{}', 'and vice-versa' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 0
    },
    rarity = 1,
    config = {},
    blueprint_compat = false,
    cost = 3,
}

SMODS.Joker { -- Harmony
    key = 'harmony',
    loc_txt = {
        name = 'Harmony',
        text = { '{C:mult}+16{} Mult if played', 'hand contains at least', '{C:attention}3{} different scoring ranks' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 1
    },
    rarity = 1,
    config = {
        extra = {
            mult = 16
        }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local ranks = {}

            for i = 1, #context.scoring_hand do
                local unique = true
                for j = 1, #ranks do
                    if ranks[j] == context.scoring_hand[i]:get_id() then
                        unique = false
                    end
                end
                if #ranks == 0 or unique then
                    ranks[#ranks + 1] = context.scoring_hand[i]:get_id()
                end
            end

            if #ranks >= 3 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = '+' .. card.ability.extra.mult,
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker { -- Impractical Joker
    key = 'impractical_joker',
    loc_txt = {
        name = 'Impractical Joker',
        text = { 'If a {C:attention}#2#{} is played,', '{X:mult,C:white}X3{} Mult. If three hands in a',
            'row are not this hand type, {X:mult,C:white}X0.5{} Mult', '{C:inactive}Hand rotates every round',
            '{C:inactive}Fail streak: #1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 3,
            fails = 0
        }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.fails, G.GAME.current_round.impractical_hand }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            -- If correct hand is played
            if context.scoring_name == G.GAME.current_round.impractical_hand then
                if not context.blueprint then
                    card.ability.extra.fails = 0
                    card.ability.extra.Xmult = 3
                end

                return {
                    message = 'X' .. card.ability.extra.Xmult,
                    Xmult_mod = card.ability.extra.Xmult,
                    colour = G.C.MULT,
                    card = card
                }

                -- If incorrect hand is played
            else
                if not context.blueprint then
                    card.ability.extra.fails = card.ability.extra.fails + 1
                end

                -- If below 3 fails
                if card.ability.extra.fails < 3 then
                    return {
                        message = 'Fail ' .. card.ability.extra.fails,
                        colour = G.C.RED,
                        card = card
                    }

                    -- If 3 fails
                elseif card.ability.extra.fails == 3 then
                    card.ability.extra.Xmult = 0.5
                    return {
                        message = 'Tonight\'s Biggest Loser',
                        Xmult_mod = card.ability.extra.Xmult,
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.fails = 0
            return {
                message = localize('k_reset'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Trick or Treat
    key = 'trick_or_treat',
    loc_txt = {
        name = 'Trick or Treat',
        text = { 'When held, {C:attention}Booster packs{}', 'now let you take one more', 'card than usual' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 1
    },
    rarity = 1,
    config = {
        extra = {
            mult = 5
        }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.choose_mod = G.GAME.choose_mod + 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.choose_mod = G.GAME.choose_mod - 1
    end,
    calculate = function(self, card, context)
        if context.open_booster then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    card:juice_up(0.3, 0.4)
                    return true
                end)
            }))
        end
    end
}

SMODS.Joker { -- Pessimistic Joker
    key = 'pessimistic',
    loc_txt = {
        name = 'Pessimistic Joker',
        text = { 'After each failed probability check,', 'this Joker gains {C:mult}Mult{} equal to the',
            'odds of failing the check', '{C:inactive}+3 for missed Lucky Card',
            '{C:inactive}Currently: {C:mult}+#1# {C:inactive}Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.individual and context.other_card.ability.effect == 'Lucky Card' and not context.after and not context.end_of_round and
            not context.other_card.lucky_trigger and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + 3
            card:juice_up(0.3, 0.4)
        end
    end
}

SMODS.Joker { -- Chef
    key = 'chef',
    loc_txt = {
        name = 'Chef',
        text = { 'Creates a random {C:attention}Food{} Joker', 'when blind is selected' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 2
    },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            local chosen_joker = nil
            while not chosen_joker or
                (chosen_joker.name == 'Cavendish' and not G.GAME.pool_flags.gros_michel_extinct) do
                chosen_joker = pseudorandom_element(food_jokers, pseudoseed('chef' .. G.GAME.round_resets.ante))
            end
            local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_joker.key, 'chef')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
            card:juice_up(0.3, 0.4)
            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
        end
    end
}

SMODS.Joker { -- Leftovers
    key = 'leftovers',
    loc_txt = {
        name = 'Leftovers',
        text = { 'Creates a new copy of', 'a {C:attention}Food{} Joker when', 'depleted or destroyed',
            '{C:inactive}Self-destructs on copy{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 2
    },
    blueprint_compat = false,
    cost = 4,
    rarity = 1,
    calculate = function(self, card, context)
        if G.GAME.destroyed_food ~= '' and not context.blueprint then
            local respawn_key = G.GAME.destroyed_food
            G.GAME.destroyed_food = ''

            G.E_MANAGER:add_event(Event({
                delay = 0.3,
                func = function()
                    play_sound('timpani')

                    local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, respawn_key, 'lefto')
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)

                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                            return true;
                        end
                    }))
                    return true
                end
            }))
            return {
                card = card,
                message = 'Saved for later!'
            }
        end
    end
}

SMODS.Joker { -- Refrigerator
    key = 'refrigerator',
    loc_txt = {
        name = 'Refrigerator',
        text = { '{C:attention}Food{} Jokers degrade', 'half as fast' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            mult = 5
        }
    },
    blueprint_compat = false,
    cost = 6,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.fridge_mod = G.GAME.fridge_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.fridge_mod = G.GAME.fridge_mod / 2
    end
}

SMODS.Joker { -- Hopscotch
    key = 'hopscotch',
    loc_txt = {
        name = 'Hopscotch',
        text = { 'When selecting blind,', '{C:green}#1# in 3{} chance to', 'receive associated skip tag' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 2
    },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.probabilities.normal }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind:get_type() ~= 'Boss' and not context.blueprint then
            local chance_roll = pseudorandom(pseudoseed('hopscotch' .. G.GAME.round_resets.ante),
                G.GAME.probabilities.normal, 3)
            if chance_roll == 3 then
                local _tag = G.GAME.skip_tag
                if _tag and _tag.config then
                    play_sound('generic1')
                    card:juice_up(0.3, 0.4)
                    add_tag(_tag.config.ref_table)
                    G.GAME.skip_tag = ''
                end
            else
                local pessimistics = SMODS.find_card('j_mxms_pessimistic')
                if next(pessimistics) then
                    for k, v in pairs(pessimistics) do
                        v.ability.extra.mult = v.ability.extra.mult +
                            (3 - G.GAME.probabilities.normal) * G.GAME.soil_mod
                        local groupchats = SMODS.find_card('j_mxms_group_chat')
                        if next(groupchats) then
                            for k, v in pairs(groupchats) do
                                v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                                v:juice_up(0.3, 0.4)
                            end
                        end
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            func = function()
                                v:juice_up(0.3, 0.4)
                                return true;
                            end
                        }))
                    end
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        play_sound('tarot2')
                        return true;
                    end
                }))
                return {
                    card = card,
                    message = localize('k_nope_ex'),
                    colour = G.C.SET.Tarot
                }
            end
        end
    end
}

SMODS.Joker { -- Secret Society
    key = 'secret_society',
    loc_txt = {
        name = 'Secret Society',
        text = { '{C:chips}Chip{} values of ranks', 'are {C:attention}swapped and doubled{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 2
    },
    blueprint_compat = false,
    cost = 5,
    rarity = 2,
    config = {}
}

SMODS.Joker { -- Bullseye
    key = 'bullseye',
    loc_txt = {
        name = 'Bullseye',
        text = { 'If {C:attention}blind\'s{} Chip requirement', 'is met {C:attention}exactly{}, this joker',
            'gains {C:chips}+#1#{} Chips', '{C:inactive}Gain is equal to 100 x Round', '{C:inactive}Currently: {C:chips}+#2#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        local gain = 100 * G.GAME.round
        if gain < 100 then
            gain = 100
        end
        return {
            vars = { gain, center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and
            G.GAME.blind.chips == G.GAME.chips then
            card.ability.extra.chips = card.ability.extra.chips + ((100 * G.GAME.round) * G.GAME.soil_mod)
            local groupchats = SMODS.find_card('j_mxms_group_chat')
            if next(groupchats) then
                for k, v in pairs(groupchats) do
                    v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                    v:juice_up(0.3, 0.4)
                end
            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Hammer and Chisel
    key = 'hammer_and_chisel',
    loc_txt = {
        name = 'Hammer and Chisel',
        text = { 'Stone cards retain', '{C:attention}rank{} and {C:attention}suit{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 2
    },
    rarity = 2,
    config = {},
    blueprint_compat = false,
    cost = 5,
    enhancement_gate = 'm_stone',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {}
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_stone') then
                v.config.center.replace_base_card = false
                v.config.center.no_rank = false
                v.config.center.no_suit = false
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_stone') then
                v.config.center.replace_base_card = true
                v.config.center.no_rank = true
                v.config.center.no_suit = true
            end
        end
    end
}

SMODS.Joker { -- Four-Leaf Clover
    key = 'four_leaf_clover',
    loc_txt = {
        name = 'Four-Leaf Clover',
        text = { 'If scored hand has exactly 4 cards,', 'convert them all to {C:attention}Lucky{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 2
    },
    rarity = 2,
    config = {},
    blueprint_compat = false,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and #context.scoring_hand == 4 then
            -- Code derived from Midas Mask
            for k, v in ipairs(context.scoring_hand) do
                if not v.debuff then
                    v:set_ability(G.P_CENTERS.m_lucky, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up(0.3, 0.4)
                            return true
                        end
                    }))
                end
            end

            return {
                message = 'Lucky',
                colour = G.C.GREEN,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Soyjoke
    key = 'soyjoke',
    loc_txt = {
        name = 'Soyjoke',
        text = { '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X0.25{} Mult', 'every time a Joker', 'is re-added to hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.soy_mod }
        }
    end,
    calculate = function(self, card, context)
        card.ability.extra.Xmult = G.GAME.soy_mod

        if context.joker_main and G.GAME.soy_mod > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Clown Car
    key = 'clown_car',
    loc_txt = {
        name = 'Clown Car',
        text = { 'Gains {C:mult}+2{} Mult each time', 'a Joker is added to hand', '{C:inactive}Currently: +#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Gambler
    key = 'gambler',
    loc_txt = {
        name = 'Gambler',
        text = { 'Capped sources of money generation', 'have their limits {C:attention}doubled{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 3
    },
    rarity = 1,
    config = {},
    blueprint_compat = false,
    cost = 7,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.gambler_mod = G.GAME.gambler_mod * 2
        G.GAME.interest_cap = G.GAME.interest_cap * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.gambler_mod = G.GAME.gambler_mod / 2
        G.GAME.interest_cap = G.GAME.interest_cap / 2
    end
}

SMODS.Joker { -- 4D
    key = '4d',
    loc_txt = {
        name = '4D Joker',
        text = { '{X:mult,C:white}X#1#{} Mult,', 'decreases by {X:mult,C:white}X0.01{}', 'every second' }
    },
    atlas = '4D',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 7
    },
    rarity = 2,
    perishable_compat = false,
    eternal_compat = false,
    blueprint_compat = true,
    cost = 6,
    config = {
        extra = {
            Xmult = 4
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.Xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if card.ability.extra.Xmult <= 1 then
            card:start_dissolve({ G.C.BLUE }, nil, 1.6)
        end
    end
}

SMODS.Joker { -- Dark Room
    key = 'dark_room',
    loc_txt = {
        name = 'Dark Room',
        text = { 'After 3 rounds, sell this', 'Joker to upgrade a random', 'owned voucher' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 3
    },
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 7,
    config = {
        extra = {
            rounds = 0
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.rounds }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and card.ability.extra.rounds == 3 and not context.blueprint then
            local voucher_pool = get_current_pool('Voucher')

            local eligible_vouchers = {}
            for i = 1, #voucher_pool do
                if voucher_pool[i] ~= 'UNAVAILABLE' and G.P_CENTERS[voucher_pool[i]].requires then
                    eligible_vouchers[#eligible_vouchers + 1] = voucher_pool[i]
                end
            end

            if #eligible_vouchers == 0 then
                return {
                    message = 'None Valid',
                    colour = G.C.FILTER,
                    card = card
                }
            end

            local chosen_voucher = create_card('Voucher', nil, nil, nil, nil, nil,
                pseudorandom_element(eligible_vouchers, pseudoseed('dark_room' .. G.GAME.round_resets.ante)), 'dark_room')
            chosen_voucher.cost = 0
            chosen_voucher:redeem()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    chosen_voucher:start_dissolve({ G.C.ORANGE }, nil, 1.6)
                    return true
                end
            }))
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and
            card.ability.extra.rounds < 3 then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == 3 then
                local eval = function(card)
                    return not card.REMOVED
                end
                juice_card_until(card, eval, true)
            end

            return {
                message = (card.ability.extra.rounds < 3) and (card.ability.extra.rounds .. '/3') or
                    localize('k_active_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Virus
    key = 'virus',
    loc_txt = {
        name = 'Virus',
        text = { 'All single-suit hands', 'with more than one card are', 'treated as a {C:attention}flush{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 3
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
}

SMODS.Joker { -- Man in the Mirror
    key = 'man_in_the_mirror',
    loc_txt = {
        name = 'Man in the Mirror',
        text = { 'Selling this joker', 'creates {C:dark_edition}Negative{} copies of',
            'all non-Negative held consumables' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 3
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 8,
    rarity = 2,
    config = {},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            -- Fail if no held consumeables
            if next(G.consumeables.cards) == nil then
                return {
                    extra = {
                        message = 'No target...',
                        colour = G.C.PURPLE
                    },
                    card = card
                }
            else
                -- Add negative edition to all held consumeables
                for k, v in ipairs(G.consumeables.cards) do
                    if not (v.edition and v.edition.negative) then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                local new_card = copy_card(v, nil, nil, nil, v.edition and v.edition.negative)
                                new_card:set_edition({
                                    negative = true
                                }, true)
                                new_card:start_materialize()
                                new_card:add_to_deck()
                                G.consumeables:emplace(new_card)
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}

SMODS.Joker { -- Unpleasant Gradient
    key = 'unpleasant_gradient',
    loc_txt = {
        name = 'Unpleasant Gradient',
        text = { 'If scored hand has exactly 4 cards,', 'convert each card into {C:clubs}Clubs{},',
            '{C:hearts}Hearts{}, {C:diamonds}Diamonds{}, and {C:spades}Spades', 'respectively from left to right' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            triggered = false
        }
    },
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and #context.scoring_hand == 4 then
            -- Code derived from Sigil
            for i = 1, #context.scoring_hand do
                local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        local other_card = context.scoring_hand[i]
                        other_card:flip()
                        play_sound('card1', percent)
                        other_card:juice_up(0.3, 0.3)
                        local rank_suffix = other_card.base.id < 10 and tostring(other_card.base.id) or
                            other_card.base.id == 10 and 'T' or other_card.base.id == 11 and 'J' or
                            other_card.base.id == 12 and 'Q' or other_card.base.id == 13 and 'K' or
                            other_card.base.id == 14 and 'A'
                        if i == 1 then
                            other_card:set_base(G.P_CARDS['C_' .. rank_suffix])
                        elseif i == 2 then
                            other_card:set_base(G.P_CARDS['H_' .. rank_suffix])
                        elseif i == 3 then
                            other_card:set_base(G.P_CARDS['D_' .. rank_suffix])
                        elseif i == 4 then
                            other_card:set_base(G.P_CARDS['S_' .. rank_suffix])
                        end
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #context.scoring_hand do
                local percent = 0.85 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        local other_card = context.scoring_hand[i]
                        other_card:flip()
                        play_sound('tarot2', percent, 0.6)
                        other_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.5)
            card.ability.extra.triggered = true
            return {
                message = 'how Unpleasant',
                colour = G.C.PURPLE,
                card = card
            }
        end

        if context.after and card.ability.extra.triggered then
            card.ability.extra.triggered = false
        end
    end
}

SMODS.Joker { -- Random Encounter
    key = 'random_encounter',
    loc_txt = {
        name = 'Random Encounter',
        text = { '{C:green}#1# in 4{} chance of', 'scored playing cards', 'gaining permanent {C:mult}+1{} Bonus Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            chance = 1
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chance * G.GAME.probabilities.normal }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local chance_roll = pseudorandom(pseudoseed('rand_enc' .. G.GAME.round_resets.ante),
                card.ability.extra.chance * G.GAME.probabilities.normal, 4)
            if chance_roll == 4 then
                context.other_card.ability.mxms_mult_perma_bonus = context.other_card.ability.mxms_mult_perma_bonus or 0
                context.other_card.ability.mxms_mult_perma_bonus = context.other_card.ability.mxms_mult_perma_bonus + 1
                return {
                    message = 'A random mult appears!',
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker { -- Jackpot
    key = 'jackpot',
    loc_txt = {
        name = 'Jackpot',
        text = { 'Played hands containing at least', '{C:green}#1# in 3{} chance to give', '{C:attention}three 7\'s{} give {C:money}$#2#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            money = 15,
            odds = 3
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.probabilities.normal, center.ability.extra.money }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local sevens = 0

            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() == 7 then
                    sevens = sevens + 1
                end
            end

            if sevens >= 3 then
                if pseudorandom(pseudoseed('jackpot' .. G.GAME.round_resets.ante)) < G.GAME.probabilities.normal / card.ability.extra.odds then
                    ease_dollars(card.ability.extra.money)
                    return {
                        message = 'Jackpot!',
                        colour = G.C.money,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Bell Curve
    key = 'bell_curve',
    loc_txt = {
        name = 'Bell Curve',
        text = { 'Approximately {X:mult,C:white}X#1#{} Mult,', 'Changes sigmoidially according to',
            'deck size\'s deviation', 'from {C:attention}52{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 3
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        local calc = 3
        if G.playing_cards ~= nil then
            calc = 2 * math.exp(-(((#G.playing_cards - 52) ^ 2) / 250)) + 1
        end
        return {
            vars = { calc }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.Xmult = 2 * math.exp(-(((#G.playing_cards - 52) ^ 2) / 250)) + 1
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Loaded Gun
    key = 'loaded_gun',
    loc_txt = {
        name = 'Loaded Gun',
        text = { 'Played {C:attention}Steel Cards{}', 'give {X:mult,C:white}X2{} Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 4
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 2
        }
    },
    blueprint_compat = true,
    cost = 8,
    enhancement_gate = 'm_steel',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.config.center == G.P_CENTERS.m_steel then
            return {
                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Coupon
    key = 'coupon',
    loc_txt = {
        name = 'Coupon',
        text = { '{C:green}#1# in 10{} chance for shop', 'Jokers to be free' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            odds = 1
        }
    },
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.odds * G.GAME.probabilities.normal }
        }
    end
}

SMODS.Joker { -- Loony Joker
    key = 'loony',
    loc_txt = {
        name = 'Loony Joker',
        text = { "{C:mult}+#1#{} Mult if played", "hand is", "a {C:attention}#2#" }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 4
    },
    rarity = 1,
    config = {
        mult = 10,
        type = 'High Card'
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.mult, center.ability.type }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                mult_mod = card.ability.mult,
                message = '+' .. card.ability.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Lazy Joker
    key = 'lazy',
    loc_txt = {
        name = 'Lazy Joker',
        text = { "{C:chips}+#1#{} Chips if played", "hand is", "a {C:attention}#2#" }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 4
    },
    rarity = 1,
    config = {
        chips = 40,
        type = 'High Card'
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.chips, center.ability.type }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                chip_mod = card.ability.chips,
                message = '+' .. card.ability.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Salt Circle
    key = 'salt_circle',
    loc_txt = {
        name = 'Salt Circle',
        text = { 'Gains {C:chips}+30{} Chips for', 'for every {C:spectral}Spectral{} card used',
            '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 4
    },
    rarity = 1,
    config = {},
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.spectrals_used * 30 }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.spectrals_used > 0 then
            return {
                chip_mod = G.GAME.spectrals_used * 30,
                message = '+' .. G.GAME.spectrals_used * 30,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Light Show
    key = 'light_show',
    loc_txt = {
        name = 'Light Show',
        text = { 'Retriggers all {C:mult}Mult{}', 'and {C:chips}Bonus{} cards' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 4
    },
    rarity = 1,
    config = {},
    blueprint_compat = true,
    cost = 5,
    enhancement_gate_set = {
        'm_bonus',
        'm_mult'
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return {}
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and
            (context.other_card.config.center == G.P_CENTERS.m_bonus or context.other_card.config.center ==
                G.P_CENTERS.m_mult) then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Monk
    key = 'monk',
    loc_txt = {
        name = 'Monk',
        text = { 'Gains {C:chips}+25{} chips for every', 'shop exited without purchase',
            '{C:inactive}Currently: {C:chips}+#1#{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            purchase_made = false,
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.MULT,
                card = card
            }
        end

        if (context.buying_card or context.open_booster or context.reroll_shop) and not context.blueprint then
            card.ability.extra.purchase_made = true
        end

        if context.ending_shop and not card.ability.extra.purchase_made then
            card:juice_up(0.3, 0.4)
            play_sound('tarot1')
            card.ability.extra.chips = card.ability.extra.chips + (25 * G.GAME.soil_mod)
            local groupchats = SMODS.find_card('j_mxms_group_chat')
            if next(groupchats) then
                for k, v in pairs(groupchats) do
                    v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                    v:juice_up(0.3, 0.4)
                end
            end
        end

        if context.setting_blind then
            card.ability.extra.purchase_made = false
        end
    end
}

SMODS.Joker { -- Marco Polo
    key = 'marco_polo',
    loc_txt = {
        name = 'Marco Polo',
        text = { '{C:mult}+12{} Mult if card is at secret placement', 'in Joker hand order. Given Mult is',
            '{C:red}subtracted by 3{} for', 'each card out of place', '{C:inactive}Position changes every round{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 4
    },
    rarity = 1,
    config = {},
    blueprint_compat = true,
    cost = 3,
    calculate = function(self, card, context)
        if context.joker_main then
            local position = 0
            for i = 0, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    position = i
                end
            end

            local mult = 12 - (3 * (math.abs(position - G.GAME.current_round.marco_polo_pos)))

            if mult < 0 then
                mult = 0
            end

            return {
                mult_mod = mult,
                message = '+' .. mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Go Fish
    key = 'go_fish',
    loc_txt = {
        name = 'Go Fish',
        text = { '{C:mult}+2{} Mult for each {C:attention}#1#{}', 'in full deck at start of round',
            '{C:inactive}Rank changes every round', '{C:inactive}Currently {C:mult}+#2# {C:inactive}Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 4
    },
    rarity = 1,
    config = {},
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.current_round.go_fish.rank, G.GAME.current_round.go_fish.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = G.GAME.current_round.go_fish.mult,
                message = '+' .. G.GAME.current_round.go_fish.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Sleuth
    key = 'sleuth',
    loc_txt = {
        name = 'Sleuth',
        text = { '{C:attention}+1 card slot{}', 'available in the shop' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 5
    },
    rarity = 1,
    config = {},
    blueprint_compat = false,
    cost = 6,
    add_to_deck = function(self, card, from_debuff)
        change_shop_size(1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-1)
    end
}

SMODS.Joker { -- Don't Mind if I Do
    key = 'dont_mind_if_i_do',
    loc_txt = {
        name = 'Don\'t Mind if I Do',
        text = { 'Gains {X:mult,C:white}X0.25{} Mult for every', 'card scored with a seal at the cost of',
            'removing the seal', '{C:inactive}Currently: {X:mult,C:white}X#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 5
    },
    blueprint_compat = false,
    cost = 7,
    rarity = 2,
    config = {
        extra = {
            Xmult = 1
        }
    },
    seal_gate = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.Xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].seal then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.50,
                        func = function()
                            local other_card = context.scoring_hand[i]
                            play_sound('card1')
                            card:juice_up(0.3, 0.3)
                            other_card:juice_up(0.3, 0.3)
                            other_card:set_seal(nil, nil, true)
                            card.ability.extra.Xmult = card.ability.extra.Xmult + (0.25 * G.GAME.soil_mod)
                            local groupchats = SMODS.find_card('j_mxms_group_chat')
                            if next(groupchats) then
                                for k, v in pairs(groupchats) do
                                    v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                                    v:juice_up(0.3, 0.4)
                                end
                            end
                            return true
                        end
                    }))
                end
            end
        end

        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Guillotine
    key = 'guillotine',
    loc_txt = {
        name = 'Guillotine',
        text = { 'Scored {C:attention}Face{} or {C:attention}Ace{} cards', 'have their rank demoted',
            'to {C:attention}10{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 5
    },
    rarity = 3,
    config = {},
    blueprint_compat = false,
    cost = 9,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() > 10 and not context.scoring_hand[i].debuff then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.50,
                        func = function()
                            local other_card = context.scoring_hand[i]
                            play_sound('slice1')
                            other_card:juice_up(0.3, 0.3)
                            local suit_prefix = string.sub(other_card.base.suit, 1, 1) .. '_'
                            other_card:set_base(G.P_CARDS[suit_prefix .. 'T'])
                            return true
                        end
                    }))
                end
            end
        end
    end
}

SMODS.Joker { -- Power Creep
    key = 'power_creep',
    loc_txt = {
        name = 'Power Creep',
        text = { '{C:attention}Scoring Editions{} are {C:attention}twice{} as potent',
            'Shop prices are {C:attention}doubled' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 5
    },
    rarity = 3,
    config = {},
    blueprint_compat = false,
    cost = 7,
    edition_gate_set = {
        'foil',
        'holo',
        'polychrome'
    },
    add_to_deck = function(self, card, from_debuff)
        G.GAME.creep_mod = G.GAME.creep_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.creep_mod = G.GAME.creep_mod / 2
    end
}

SMODS.Joker { -- Space Race
    key = 'space_race',
    loc_txt = {
        name = 'Space Race',
        text = { 'If played hand is not the highest', 'level hand, upgrade hand by one level',
            '{C:inactive}Hands tied for highest do not upgrade{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 5
    },
    rarity = 3,
    config = {},
    blueprint_compat = true,
    cost = 7,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
            local hand_is_highest = false

            local hand, level, highest = nil, 0, {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and v.level > level then
                    hand = k
                    level = v.level
                    highest = { hand }
                elseif v.visible and v.level == level then
                    highest[#highest + 1] = k
                end
            end

            for i = 1, #highest do
                if context.scoring_name == highest[i] then
                    hand_is_highest = true
                end
            end

            if not hand_is_highest then
                return {
                    card = card,
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}

SMODS.Joker { -- Poet
    key = 'poet',
    loc_txt = {
        name = 'Poet',
        text = { 'If hand type is played {C:attention}exclusively{} with number ranks', 'matching the {C:attention}hand name{}, give {X:mult,C:white}Xmult{} equal to that rank', '{C:inactive}Two Pair must be played with a pair of 2s and', '{C:inactive}a pair of faces or aces' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 5
    },
    rarity = 2,
    config = {},
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            local same_rank = true
            if context.scoring_name == 'Two Pair' then
                local two_count = 0
                local face_count = 0
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() == 2 then
                        two_count = two_count + 1
                    elseif v:get_id() > 10 then
                        face_count = face_count + 1
                    end
                end

                if two_count == 2 and face_count == 2 then
                    return {
                        message = 'X2',
                        Xmult_mod = 2,
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end

            if context.scoring_name == 'Three of a Kind' then
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() ~= 3 then
                        same_rank = false
                    end
                end

                if same_rank then
                    return {
                        message = 'X3',
                        Xmult_mod = 3,
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end

            if context.scoring_name == 'Four of a Kind' then
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() ~= 4 then
                        same_rank = false
                    end
                end

                if same_rank then
                    return {
                        message = 'X4',
                        Xmult_mod = 4,
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end

            if context.scoring_name == 'Five of a Kind' or context.scoring_name == 'Flush Five' then
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() ~= 5 then
                        same_rank = false
                    end
                end

                if same_rank then
                    return {
                        message = 'X5',
                        Xmult_mod = 5,
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Hedonist
    key = 'hedonist',
    loc_txt = {
        name = 'Hedonist',
        text = { '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X0.25{} Mult', 'if shop is cleared out', 'when exiting' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 5
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 1
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.Xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = "X" .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.ending_shop and #G.shop_vouchers.cards == 0 and #G.shop_booster.cards == 0 and #G.shop_jokers.cards == 0 and not context.blueprint then
            card:juice_up(0.3, 0.4)
            play_sound('tarot1')
            card.ability.extra.Xmult = card.ability.extra.Xmult + (0.25 * G.GAME.soil_mod)
            local groupchats = SMODS.find_card('j_mxms_group_chat')
            if next(groupchats) then
                for k, v in pairs(groupchats) do
                    v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                    v:juice_up(0.3, 0.4)
                end
            end
        end
    end
}

SMODS.Joker { -- Zombie
    key = 'zombie',
    loc_txt = {
        name = 'Zombie',
        text = { 'Copies the effect of {C:attention}one random Joker{}', 'each round. The target Joker will {C:attention}turn into', '{C:attention}another Zombie{} at the end of the round', '{C:inactive}All zombies target the same Joker', '{C:inactive}Zombification can be stopped by selling all other zombies', '{C:inactive}Current target: {C:red}#1#{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 5
    },
    rarity = 2,
    config = {},
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        if G.GAME.current_round.zombie_target ~= nil then
            local copied_key = G.GAME.current_round.zombie_target.config.center.key
            info_queue[#info_queue + 1] = G.P_CENTERS[copied_key]
            return {
                vars = { G.localization.descriptions.Joker[copied_key].name }
            }
        else
            return {
                vars = { 'No valid target' }
            }
        end
    end,
    calculate = function(self, card, context)
        if G.GAME.current_round.zombie_target and not context.no_blueprint then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            local zombie_target_ret = G.GAME.current_round.zombie_target:calculate_joker(context)
            context.blueprint = nil
            local eff_card = context.blueprint_card or self
            context.blueprint_card = nil
            if zombie_target_ret then
                zombie_target_ret.card = eff_card
                zombie_target_ret.colour = G.C.GREEN
                return zombie_target_ret
            end
        end
    end
}

SMODS.Joker { -- Coronation
    key = 'coronation',
    loc_txt = {
        name = 'Coronation',
        text = { 'If {C:attention}Joker{} is in', 'hand after {C:attention}1 full ante {C:inactive}(No skips){},', 'upgrade {C:attention}Joker{} to {C:attention}Joker+{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 5
    },
    rarity = 3,
    config = {
        extra = {
            rounds = 0,
            skips_used = false
        }
    },
    blueprint_compat = true,
    cost = 7,
    joker_gate = 'j_joker',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_joker
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and next(SMODS.find_card('j_joker')) then
            if not card.ability.extra.skips_used then
                if G.GAME.round % 3 == 0 then
                    if card.ability.extra.rounds == 3 then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            func = function()
                                local jimbo = SMODS.find_card('j_joker')[1]

                                local new_jimbo = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mxms_joker_plus',
                                    'coron')
                                if jimbo.edition then
                                    new_jimbo:set_edition(jimbo.edition, nil, true)
                                end
                                jimbo:start_dissolve({ G.C.YELLOW }, nil, 1.6)
                                G.jokers:emplace(new_jimbo)

                                play_sound('polychrome1')
                                return true;
                            end
                        }))

                        card.ability.extra.rounds = 0
                        card.ability.extra.skips_used = false

                        return {
                            message = 'Crowned',
                            colour = G.C.YELLOW,
                            card = card
                        }
                    end
                elseif card.ability.extra.rounds > 0 then
                    return {
                        message = card.ability.extra.rounds .. '/3',
                        colour = G.C.YELLOW,
                        card = card
                    }
                end
            end
        end

        if context.setting_blind and (card.ability.extra.rounds > 0 or G.GAME.round % 3 == 1) then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
        end

        if context.skip_blind then
            card.ability.extra.skips_used = true
            return {
                message = localize('k_reset'),
                colour = G.C.YELLOW,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Soil Joker
    key = 'soil',
    loc_txt = {
        name = 'Soil Joker',
        text = { 'Scaling Jokers gain', '{C:attention}twice{} as much scaling value' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 6
    },
    rarity = 3,
    config = {},
    blueprint_compat = false,
    cost = 8,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.soil_mod = G.GAME.soil_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.soil_mod = G.GAME.soil_mod / 2
    end
}

SMODS.Joker { -- Stop Sign
    key = 'stop_sign',
    loc_txt = {
        name = 'Stop Sign',
        text = { 'Jokers that have rotating', 'requirements {C:attention}no longer change{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 6
    },
    rarity = 3,
    config = {},
    blueprint_compat = true,
    cost = 8,
}

SMODS.Joker { -- Chihuahua
    key = 'chihuahua',
    loc_txt = {
        name = 'Chihuahua',
        text = { 'Retriggers cards with ranks that appear', 'the least number of times in the deck the', 'same number of times that rank appears', '{C:inactive}Does not activate if there is a tie{}', '{C:inactive}Limit of 10 retriggers{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 6
    },
    rarity = 3,
    config = {
        extra = {
            least_id = '0',
            least_count = 0,
            tie = false
        }
    },
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        if context.before then
            local ranks = {
                ["2"] = { freq = 0, id = '2' },
                ["3"] = { freq = 0, id = '3' },
                ["4"] = { freq = 0, id = '4' },
                ["5"] = { freq = 0, id = '5' },
                ["6"] = { freq = 0, id = '6' },
                ["7"] = { freq = 0, id = '7' },
                ["8"] = { freq = 0, id = '8' },
                ["9"] = { freq = 0, id = '9' },
                ["10"] = { freq = 0, id = '10' },
                ["11"] = { freq = 0, id = '11' },
                ["12"] = { freq = 0, id = '12' },
                ["13"] = { freq = 0, id = '13' },
                ["14"] = { freq = 0, id = '14' }
            }

            for i = 1, #G.playing_cards do
                if not SMODS.has_no_rank(G.playing_cards[i]) then
                    ranks[tostring(G.playing_cards[i].base.id)].freq = ranks[tostring(G.playing_cards[i].base.id)].freq +
                        1
                end
            end

            for k, v in pairs(ranks) do
                if v.freq ~= 0 then
                    if v.freq < card.ability.extra.least_count or card.ability.extra.least_count == 0 then
                        card.ability.extra.least_id = v.id
                        card.ability.extra.least_count = v.freq
                        card.ability.extra.tie = false
                    elseif v.freq == card.ability.extra.least_count then
                        card.ability.extra.tie = true
                    end
                end
            end
        end

        if context.cardarea == G.play and context.repetition and tostring(context.other_card.base.id) == card.ability.extra.least_id and not card.ability.extra.tie then
            local reps
            if card.ability.extra.least_count <= 10 then
                reps = card.ability.extra.least_count
            else
                reps = 10
            end
            return {
                message = localize('k_again_ex'),
                repetitions = reps,
                card = card
            }
        end

        if context.after then
            card.ability.extra.least_id = '0'
            card.ability.extra.least_count = 0
            card.ability.extra.tie = false
        end
    end
}

SMODS.Joker { -- Ledger
    key = 'ledger',
    loc_txt = {
        name = 'Ledger',
        text = { 'At the end of every ante, one', 'random Joker becomes {C:dark_edition}Negative{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 7
    },
    soul_pos = {
        x = 0,
        y = 8
    },
    cost = 20,
    rarity = 4,
    config = {},
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and G.GAME.round % 3 == 0 then
            local eligible_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].edition and not G.jokers.cards[i].getting_sliced then
                    eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                end
            end

            -- Fail if no held jokers are eligible
            if next(eligible_jokers) == nil then
                return {
                    extra = {
                        message = 'No target...',
                        colour = G.C.PURPLE
                    },
                    card = card
                }
            else
                -- Choose Joker to affect
                local chosen_joker =
                    #eligible_jokers > 0 and
                    pseudorandom_element(eligible_jokers, pseudoseed('ledger' .. G.GAME.round_resets.ante)) or nil

                -- Add negative edition to random held joker

                if chosen_joker ~= nil then
                    chosen_joker:set_edition({
                        negative = true
                    }, true)
                    return {
                        extra = {
                            message = 'Why so serious?',
                            colour = G.C.PURPLE
                        },
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Bootleg
    key = 'bootleg',
    loc_txt = {
        name = 'Bootleg',
        text = { 'Copies the effect of the', '{C:attention}most recently purchased Joker', '{C:inactive}Current effect: {C:red}#1#{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 6
    },
    rarity = 3,
    config = {},
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, center)
        if G.GAME.last_bought ~= nil then
            local copied_key = G.GAME.last_bought.config.center.key
            info_queue[#info_queue + 1] = G.P_CENTERS[copied_key]
            return {
                vars = { G.localization.descriptions.Joker[copied_key].name }
            }
        else
            return {
                vars = { 'None' }
            }
        end
    end,
    calculate = function(self, card, context)
        if G.GAME.last_bought and not context.no_blueprint then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            local bootleg_target_ret = G.GAME.last_bought:calculate_joker(context)
            context.blueprint = nil
            local eff_card = context.blueprint_card or self
            context.blueprint_card = nil
            if bootleg_target_ret then
                bootleg_target_ret.card = eff_card
                bootleg_target_ret.colour = G.C.YELLOW
                return bootleg_target_ret
            end
        end

        if context.buying_card and context.card.config.center.blueprint_compat and (context.card ~= card or context.card.config.center.key ~= "j_mxms_bootleg") then
            G.GAME.last_bought = context.card
            card:juice_up(0.3, 0.4)
        end
    end,
    remove_from_deck = function(self, card, context)
        if not next(SMODS.find_card('j_mxms_bootleg')) then
            G.GAME.last_bought = nil
        end
    end
}

SMODS.Joker { -- Group Chat
    key = 'group_chat',
    loc_txt = {
        name = 'Group Chat',
        text = { 'Gains {C:chips}+2{} Chips', 'whenever another Joker scales', '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Minimalist
    key = 'minimalist',
    loc_txt = {
        name = 'Minimalist',
        text = { '{C:chips}+90{} Chips, {C:chips}-15{} for', 'every enhanced card in full deck', '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            chips = 90
        }
    },
    blueprint_compat = false,
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end,
    update = function(self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.chips = 90
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) and card.ability.extra.chips > 0 then
                    card.ability.extra.chips = card.ability.extra.chips - 15
                end
            end
        end
    end
}

SMODS.Joker { -- Endless Breadsticks
    key = 'breadsticks',
    loc_txt = {
        name = 'Endless Breadsticks',
        text = { 'Gains {C:chips}+25{} Chips every {C:attention}#1#{} cards', 'discarded this round. Discard requirement', 'increases by {C:attention}1{} and resets {C:chips}Chips{}', 'each round', '{C:inactive}Currently: {C:chips}+#2#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            d_requirement = 2,
            d_tally = 0,
            chips = 0
        }
    },
    blueprint_compat = false,
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.d_requirement, center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not context.other_card.debuff then
            card.ability.extra.d_tally = card.ability.extra.d_tally + 1
            if card.ability.extra.d_tally < card.ability.extra.d_requirement then
                return {
                    delay = 0.2,
                    message = card.ability.extra.d_tally .. '/' .. card.ability.extra.d_requirement,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                card.ability.extra.chips = card.ability.extra.chips + 25 * G.GAME.soil_mod
                card.ability.extra.d_tally = 0
                return {
                    delay = 0.2,
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end

        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.d_tally = 0
            card.ability.extra.chips = 0
            card.ability.extra.d_requirement = card.ability.extra.d_requirement + 1
            return {
                message = 'More Please!',
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Glass Cannon
    key = 'glass_cannon',
    loc_txt = {
        name = 'Glass Cannon',
        text = { 'All Joker {X:mult,C:white}XMult{} is {C:attention}retriggered', '{C:attention}Shatters{} if blind isn\'t', 'beaten in 2 hands' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 6
    },
    rarity = 3,
    config = {
        extra = {
            hands = 0
        }
    },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.other_ret
            and context.retrigger_joker_check and not context.retrigger_joker
            and (context.other_ret.jokers and (context.other_ret.jokers.Xmult or context.other_ret.jokers.Xmult_mod)) then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end

        if context.after and not context.blueprint then
            card.ability.extra.hands = card.ability.extra.hands + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    if card.ability.extra.hands == 2 and G.GAME.chips - G.GAME.blind.chips < 0 then
                        card:shatter()
                    end
                    return true
                end
            }))
        end


        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.hands = 0
        end
    end
}

SMODS.Joker { -- Gravity
    key = 'gravity',
    loc_txt = {
        name = 'Gravity',
        text = { '{C:attention}+#1#{} levels to all Poker hands', '{C:attention}-1{} level every round' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 6
    },
    rarity = 2,
    config = {
        extra = {
            rounds = 5
        }
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.rounds }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot2')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '-', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot2')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '-', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot2')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '-1' })
            delay(1.3)
            for k, v in pairs(G.GAME.hands) do
                level_up_hand(self, k, true, -1)
            end
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
            card.ability.extra.rounds = card.ability.extra.rounds - 1

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    if card.ability.extra.rounds == 0 then
                        card:start_dissolve({ G.C.RED }, nil, 1.6)
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                            { message = 'Splat!', colour = G.C.RED })
                    end
                    return true
                end
            }))
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+5' })
        delay(1.3)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true, 5)
        end
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.rounds > 0 then
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot2')
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '-', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot2')
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '-', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot2')
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 },
                { level = '-' .. card.ability.extra.rounds })
            delay(1.3)
            for k, v in pairs(G.GAME.hands) do
                level_up_hand(self, k, true, -(card.ability.extra.rounds))
            end
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
        end
    end
}

SMODS.Joker { -- Fog
    key = 'fog',
    loc_txt = {
        name = 'Fog',
        text = { '{C:attention}Four of a Kinds{} contain {C:attention}Two Pairs{}', 'Two Pairs with a {C:attention}1-rank difference{} count', 'as Four of a Kinds {C:inactive}(ex. 6 6 5 5)' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 9
    },
    blueprint_compat = false,
    cost = 5,
    rarity = 2,
    config = {}
}

SMODS.Joker { -- Stone Thrower
    key = 'stone_thrower',
    loc_txt = {
        name = 'Stone Thrower',
        text = { 'Gains {C:chips}+30{} Chips for every', 'scored {C:attention}glass card{}', 'Glass cards are {C:attention}guaranteed to break{}', '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 9
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = false,
    enhancement_gate = 'm_glass',
    cost = 3,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {
            vars = { center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.individual and context.cardarea == G.play and context.other_card.config.center == G.P_CENTERS.m_glass then
            card.ability.extra.chips = card.ability.extra.chips + 30 * G.GAME.soil_mod
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.CHIPS })
        end
    end
}

SMODS.Joker { -- Four Course Meal
    key = 'four_course_meal',
    loc_txt = {
        name = 'Four Course Meal',
        text = { 'For the next 4 hands,', 'give {C:chips}+150{} Chips, {C:mult}+30{} Mult,', '{X:mult,C:white}X3{} Mult, and {C:money}$10{}', 'respectively' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 9
    },
    rarity = 3,
    config = {
        extra = {
            hands = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.hands = card.ability.extra.hands + (1 * G.GAME.fridge_mod)
            if card.ability.extra.hands <= 1 then
                return {
                    message = '+150',
                    chip_mod = 150,
                    colour = G.C.chips,
                    card = card
                }
            elseif card.ability.extra.hands <= 2 then
                return {
                    message = '+30',
                    mult_mod = 30,
                    colour = G.C.mult,
                    card = card
                }
            elseif card.ability.extra.hands <= 3 then
                return {
                    message = 'X3',
                    Xmult_mod = 3,
                    colour = G.C.mult,
                    card = card
                }
            elseif card.ability.extra.hands <= 4 then
                ease_dollars(10)
                return {
                    message = '$10',
                    colour = G.C.money,
                    card = card
                }
            end
        end

        if context.after and card.ability.extra.hands >= 4 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(self)
                            card:remove()
                            card = nil
                            return true;
                        end
                    }))
                    return true
                end
            }))
            return {
                message = localize('k_eaten_ex'),
                colour = G.C.RED
            }
        end
    end
}

SMODS.Joker { -- Memory Game
    key = 'memory_game',
    loc_txt = {
        name = 'Memory Game',
        text = { 'If played hand is', 'a {C:attention}Pair{}, convert', 'the first scoring card', 'into the second scoring card' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 9
    },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Pair" and not context.blueprint then
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)

            for i = 1, 2 do
                local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                context.scoring_hand[i]:flip();
                play_sound('card1', percent);
                context.scoring_hand[i]:juice_up(0.3, 0.3);
            end
            delay(0.2)

            copy_card(context.scoring_hand[2], context.scoring_hand[1])

            for i = 1, 2 do
                local percent = 0.85 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        context.scoring_hand[i]:flip();
                        play_sound('card1', percent);
                        context.scoring_hand[i]:juice_up(0.3, 0.3);
                        return true
                    end
                }))
            end
            delay(0.5)
        end
    end
}

SMODS.Joker { -- Rock Slide
    key = 'rock_slide',
    loc_txt = {
        name = 'Rock Slide',
        text = { 'If played hand is', '{C:attention}5 Stone Cards,{} add', '5 random Stone Card', 'to the deck' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 9
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    enhancement_gate = 'm_stone',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.before and #context.scoring_hand == 5 then
            local stone_tally = 0
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, 'm_stone') then
                    stone_tally = stone_tally + 1
                end
            end

            if stone_tally == 5 then
                for i = 1, stone_tally do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local front = pseudorandom_element(G.P_CARDS, pseudoseed('slide_fr'))
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local card = Card(G.play.T.x + G.play.T.w / 2, G.play.T.y, G.CARD_W, G.CARD_H, front,
                                G.P_CENTERS.m_stone, { playing_card = G.playing_card })
                            card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                            G.deck:emplace(card)
                            table.insert(G.playing_cards, card)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        { message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced })
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + stone_tally
                            return true
                        end
                    }))
                end
                playing_card_joker_effects({ true })
            end
        end
    end
}

SMODS.Joker { -- First Aid Kit
    key = 'first_aid_kit',
    loc_txt = {
        name = 'First Aid Kit',
        text = { 'Sell this card for', '{C:blue}+2{} hands and {C:red}+2{} discards', 'for the current round' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 9
    },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
                    G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 2
                    hand_UI.config.object:update()
                    G.HUD:recalculate()
                    attention_text({
                        text = '+' .. 2,
                        scale = 0.8,
                        hold = 0.7,
                        cover = hand_UI.parent,
                        cover_colour = G.C.GREEN,
                        align = 'cm',
                    })
                    play_sound('chips2')
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')
                    G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + 2
                    discard_UI.config.object:update()
                    G.HUD:recalculate()
                    attention_text({
                        text = '+' .. 2,
                        scale = 0.8,
                        hold = 0.7,
                        cover = discard_UI.parent,
                        cover_colour = G.C.GREN,
                        align = 'cm',
                    })
                    play_sound('chips2')
                    return true
                end
            }))
        end
    end
}

SMODS.Joker { -- Hype Man
    key = 'hypeman',
    loc_txt = {
        name = 'Hype Man',
        text = { 'Gives {C:money}$#1#{} every', 'time a card is', '{C:attention}enhanced{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 9
    },
    rarity = 1,
    config = {
        extra = {
            dollars = 1
        }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.dollars }
        }
    end
}

SMODS.Joker { -- Game Review
    key = 'review',
    loc_txt = {
        name = 'Game Review',
        text = { 'Retrigger each played', '{C:attention}6{}, {C:attention}7{}, {C:attention}8{}, {C:attention}9{}, or {C:attention}10' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 9
    },
    rarity = 2,
    config = {
        extra = 1
    },
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 6 or
                context.other_card:get_id() == 7 or
                context.other_card:get_id() == 8 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 10 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
    end
}

--endregion

--region Vouchers

SMODS.Voucher { -- Launch Code
    key = 'launch_code',
    loc_txt = {
        name = 'Launch Code',
        text = { '{C:attention}+#1#{} ante,', '{C:blue}+#2#{} hand and', '{C:red}+#2#{} discard', 'each round' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            ante_mod = 1,
            val_mod = 1
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.ante_mod, center.ability.extra.val_mod }
        }
    end,
    redeem = function(self, card, from_debuff)
        ease_ante(card.ability.extra.ante_mod)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.ante_mod

        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.val_mod
        ease_hands_played(card.ability.extra.val_mod)

        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.val_mod
        ease_discard(card.ability.extra.val_mod)
    end,
    in_pool = function(self, args)
        if G.GAME.round_resets.ante == G.GAME.win_ante then
            return false
        end

        return true
    end
}

SMODS.Voucher { -- Warp Drive
    key = 'warp_drive',
    loc_txt = {
        name = 'Warp Drive',
        text = { '{C:attention}+#1#{} ante,', '{C:blue}+#2#{} hands and', '{C:red}+#2#{} discards', 'each round' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = {
            ante_mod = 1,
            val_mod = 2
        }
    },
    requires = { 'v_mxms_launch_code' },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.ante_mod, center.ability.extra.val_mod }
        }
    end,
    redeem = function(self, card)
        ease_ante(card.ability.extra.ante_mod)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.ante_mod

        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.val_mod
        ease_hands_played(card.ability.extra.val_mod)

        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.val_mod
        ease_discard(card.ability.extra.val_mod)
    end,
    in_pool = function(self, args)
        if G.GAME.round_resets.ante == G.GAME.win_ante then
            return false
        end

        return true
    end
}

SMODS.Voucher { -- Sharp Suit
    key = 'sharp_suit',
    loc_txt = {
        name = 'Sharp Suit',
        text = { '{C:attention}Arcana Packs{} always', 'contain the {C:tarot}Tarot{}', 'card for the {C:attention}most', '{C:attention}numerous suit{} in', 'your deck' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 1,
        y = 0
    },
}

SMODS.Voucher { -- Best Dressed
    key = 'best_dressed',
    loc_txt = {
        name = 'Best Dressed',
        text = { 'Suit-Changing {C:tarot}Tarot{} cards in', 'your {C:attention}consumable{} area give', '{X:mult,C:white}X1{} Mult plus {X:red,C:white}X#1#{}', 'for each {C:attention}played card{}', 'matching its suit' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = 0.2
    },
    requires = { 'v_mxms_sharp_suit' },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra }
        }
    end,
    calculate = function(self, card, context)
        if context.other_consumeable and context.other_consumeable.ability.set == 'Tarot' and context.other_consumeable.ability.consumeable.suit_conv then
            local suit_tally = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit(context.other_consumeable.ability.consumeable.suit_conv, false) then
                    suit_tally = suit_tally + 1
                end
            end
            if suit_tally > 0 then
                return {
                    x_mult = card.ability.extra * suit_tally + 1
                }
            end
        end
    end,
}

SMODS.Voucher { -- Shield
    key = 'shield',
    loc_txt = {
        name = 'Shield',
        text = { '{C:spectral}Spectral{} cards that destroy Jokers', 'only have a {C:green}1 in 2{} chance', 'to destroy each Joker' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 0
    },
    redeem = function(self, card, from_debuff)
        G.GAME.v_destroy_reduction = G.GAME.v_destroy_reduction + 1
    end
}

SMODS.Voucher { -- Guardian
    key = 'guardian',
    loc_txt = {
        name = 'Guardian',
        text = { '{C:spectral}Spectral{} cards that', 'destroy Jokers', 'no longer do so' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 1
    },
    requires = { 'v_mxms_shield' },
    redeem = function(self, card, from_debuff)
        G.GAME.v_destroy_reduction = G.GAME.v_destroy_reduction + 1
    end
}

--endregion

--region Challenges

SMODS.Challenge { -- The 52 Commandments
    key = '52_commandments',
    loc_txt = {
        name = 'The 52 Commandments'
    },
    rules = {
        custom = {
            { id = 'mxms_X_blind_size', value = 2 }
        }
    },
    jokers = {
        { id = 'j_mxms_hammer_and_chisel', eternal = true }
    },
    deck = {
        type = 'Challenge Deck',
        enhancement = 'm_stone'
    }
}

SMODS.Challenge { -- Stardust Crusaders
    key = 'crusaders',
    loc_txt = {
        name = 'Stardust Crusaders'
    },
    rules = {},
    jokers = {},
    vouchers = {
        { id = 'v_tarot_merchant' }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_magic_trick' },
            { id = 'v_illusion' },
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
            { id = 'j_dna' },
            { id = 'c_cryptid' },
        }
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = "D", r = "K" },
            { s = "D", r = "K" },
            { s = "D", r = "K" },
            { s = "D", r = "K" },
            { s = "D", r = "K" }
        }
    }
}

SMODS.Challenge { -- Overgrowth
    key = 'overgrowth',
    loc_txt = {
        name = 'Overgrowth'
    },
    rules = {
        custom = {
            { id = 'mxms_X_blind_scale', value = 8 }
        }
    },
    jokers = {
        { id = 'j_mxms_soil', edition = 'negative', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

SMODS.Challenge { -- It's Hip to be Square
    key = 'square',
    loc_txt = {
        name = 'It\'s Hip to be Square'
    },
    rules = {
        custom = {
            { id = 'mxms_highlight_limit', value = 4 }
        }
    },
    jokers = {},
    restrictions = {
        banned_other = {
            { id = 'bl_psychic', type = 'blind' }
        }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

SMODS.Challenge { -- Let's Go Gambling!
    key = 'gambling',
    loc_txt = {
        name = 'Let\'s Go Gambling!'
    },
    rules = {
        custom = {
            { id = 'no_extra_hand_money' },
            { id = 'no_reward' },
            { id = 'no_interest' }
        },
        modifiers = {
            { id = 'dollars', value = 10 }
        }
    },
    jokers = {},
    restrictions = {
        banned_cards = {
            { id = 'c_temperance' },
            { id = 'c_hermit' },
            { id = 'c_devil' },
            { id = 'c_magician' },
            { id = 'c_immolate' },
            { id = 'c_talisman' },
            { id = 'j_egg' },
            { id = 'j_matador' },
            { id = 'j_golden' },
            { id = 'j_delayed_grat' },
            { id = 'j_business' },
            { id = 'j_faceless' },
            { id = 'j_todo_list' },
            { id = 'j_cloud_9' },
            { id = 'j_rocket' },
            { id = 'j_gift' },
            { id = 'j_reserved_parking' },
            { id = 'j_mail' },
            { id = 'j_to_the_moon' },
            { id = 'j_trading' },
            { id = 'j_ticket' },
            { id = 'j_rough_gem' },
            { id = 'j_satellite' },
            { id = 'j_mxms_gambler' },
            { id = 'j_mxms_jackpot' },
            { id = 'j_mxms_four_course_meal' },
            { id = 'j_mxms_hypeman' },
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
        },
        banned_tags = {
            { id = 'tag_uncommon' },
            { id = 'tag_rare' },
            { id = 'tag_negative' },
            { id = 'tag_foil' },
            { id = 'tag_holo' },
            { id = 'tag_polychrome' },
            { id = 'tag_voucher' },
            { id = 'tag_boss' },
            { id = 'tag_standard' },
            { id = 'tag_charm' },
            { id = 'tag_meteor' },
            { id = 'tag_buffoon' },
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_ethereal' },
            { id = 'tag_coupon' },
            { id = 'tag_double' },
            { id = 'tag_juggle' },
            { id = 'tag_d_six' },
            { id = 'tag_top_up' },
            { id = 'tag_orbital' },
        }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

SMODS.Challenge { -- Target Practice
    key = 'target_practice',
    loc_txt = {
        name = 'Target Practice'
    },
    rules = {
        custom = {
            { id = 'mxms_bullseye_requirement', value = 500 }
        }
    },
    jokers = {
        { id = 'j_mr_bones',      edition = 'negative' },
        { id = 'j_mxms_bullseye', edition = 'negative', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

SMODS.Challenge { -- Tonight's Biggest Loser
    key = 'biggest_loser',
    loc_txt = {
        name = 'Tonight\'s Biggest Loser'
    },
    rules = {
        custom = {
            { id = 'mxms_biggest_loser' }
        }
    },
    jokers = {
        { id = 'j_mxms_stop_sign',         edition = 'negative', eternal = true },
        { id = 'j_mxms_impractical_joker', edition = 'negative', eternal = true, posted = true }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

SMODS.Challenge { -- Picky Eater
    key = 'picky',
    loc_txt = {
        name = 'Picky Eater'
    },
    rules = {
        custom = {
            { id = 'mxms_picky' }
        }
    },
    jokers = {},
    deck = {
        type = 'Challenge Deck'
    }
}

SMODS.Challenge { -- Fashion Disaster
    key = 'fashion',
    loc_txt = {
        name = 'Fashion Disaster'
    },
    rules = {
        custom = {
            { id = 'mxms_random_suit_debuff' }
        }
    },
    jokers = {},
    restrictions = {
        banned_other = {
            { id = 'bl_club',   type = 'blind' },
            { id = 'bl_goad',   type = 'blind' },
            { id = 'bl_head',   type = 'blind' },
            { id = 'bl_window', type = 'blind' }
        }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

SMODS.Challenge { -- All Stars
    key = 'all_stars',
    loc_txt = {
        name = 'All Stars'
    },
    rules = {
        custom = {
            { id = 'mxms_all_rare' }
        }
    },
    jokers = {},
    restrictions = {
        banned_cards = {
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
            { id = 'p_arcana_normal_1', ids = {
                'p_arcana_normal_1', 'p_arcana_normal_2',
                'p_arcana_normal_3', 'p_arcana_normal_4',
                'p_arcana_jumbo_1', 'p_arcana_jumbo_2',
                'p_arcana_mega_1', 'p_arcana_mega_2' }
            },
            { id = 'p_celestial_normal_1', ids = {
                'p_celestial_normal_1', 'p_celestial_normal_2',
                'p_celestial_normal_3', 'p_celestial_normal_4',
                'p_celestial_jumbo_1', 'p_celestial_jumbo_2',
                'p_celestial_mega_1', 'p_celestial_mega_2' }
            },
            { id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1', 'p_buffoon_normal_2',
                'p_buffoon_jumbo_1', 'p_buffoon_mega_1' }
            },
        }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

-- Custom Rule Hooks
local gsr = G.start_run
function Game:start_run(args)
    gsr(self, args)
    if G.GAME.modifiers.mxms_X_blind_scale then
        G.GAME.modifiers.scaling = G.GAME.modifiers.mxms_X_blind_scale
    end
end

local bsb = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
    bsb(self, blind, reset, silent)
    if blind and blind.name and G.GAME.modifiers.mxms_picky and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
        local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mxms_four_course_meal', 'picky')
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        new_card:juice_up(0.3, 0.4)
        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
    end
    if blind and blind.name and G.GAME.modifiers.mxms_random_suit_debuff then
        local suits = { 'Clubs', 'Spades', 'Hearts', 'Diamonds' }
        G.GAME.modifiers.mxms_random_suit_debuff = pseudorandom_element(suits,
            pseudoseed('fashion' .. G.GAME.round_resets.ante))
        for _, v in ipairs(G.playing_cards) do
            self:debuff_card(v)
        end
    end
end

local bdc = Blind.debuff_card
function Blind:debuff_card(card, from_blind)
    bdc(self, card, from_blind)
    if G.GAME.modifiers.mxms_random_suit_debuff and card.area ~= G.jokers then
        if card:is_suit(G.GAME.modifiers.mxms_random_suit_debuff, true) then
            card:set_debuff(true)
            if card.debuff then card.debuffed_by_blind = true end
            return
        end
    end
end

--endregion

--region Backs

SMODS.Back { --Sixth Finger
    key = 'sixth_finger',
    loc_txt = {
        name = 'Sixth Finger Deck',
        text = { 'Increases maximum highlight', 'limit to {C:attention}6 cards{}' }
    },
    atlas = 'Backs',
    pos = {
        x = 0,
        y = 0
    },
    apply = function(self, back)
        --Change highlight limit
        G.GAME.modifiers.mxms_highlight_limit = 6

        -- Make non-secret hands visible
        G.GAME.hands.mxms_three_pair.visible = true
        G.GAME.hands.mxms_double_triple.visible = true
        G.GAME.hands.mxms_s_straight.visible = true
        G.GAME.hands.mxms_s_flush.visible = true
        G.GAME.hands.mxms_house_party.visible = true
        G.GAME.hands.mxms_s_straight_f.visible = true
    end
}

SMODS.Back { --Nirvana
    key = 'nirvana',
    loc_txt = {
        name = 'Nirvana Deck',
        text = { 'Rerolls start at {C:money}$0{}', 'Shop items cost 1.5x as much' }
    },
    atlas = 'Backs',
    pos = {
        x = 1,
        y = 0
    },
    apply = function(self, back)
        --Change shop prices
        G.GAME.shop_price_multiplier = 1.5

        -- Change reroll starting price
        G.GAME.starting_params.reroll_cost = 0
    end
}

SMODS.Back { --Nuclear
    key = 'nuclear',
    loc_txt = {
        name = 'Nuclear Deck',
        text = { '{C:mult}Mult{} is now an {C:attention}exponent{} of {C:chips}Chips{}', 'Blind Sizes are multiplied', 'to the {C:red}ante-th power{}', '{C:inactive}This deck will not count towards best hand scores' }
    },
    atlas = 'Backs',
    pos = {
        x = 2,
        y = 0
    },
    apply = function(self, back)
        --Change blind scaling
        G.GAME.modifiers.mxms_nuclear_size = true
    end
}

--endregion

--region Hand Parts

SMODS.PokerHandPart {
    key = '6',
    func = function(hand)
        return get_X_same(6, hand)
    end
}

SMODS.PokerHandPart {
    key = 's_flush',
    func = function(hand)
        if G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger' then
            local ret = {}
            local four_fingers = next(find_joker('Four Fingers'))
            local suits = SMODS.Suit.obj_buffer
            if #hand < (6 - (four_fingers and 1 or 0)) then
                return ret
            else
                for j = 1, #suits do
                    local t = {}
                    local suit = suits[j]
                    local flush_count = 0
                    for i = 1, #hand do
                        if hand[i]:is_suit(suit, nil, true) then
                            flush_count = flush_count + 1; t[#t + 1] = hand[i]
                        end
                    end
                    if flush_count >= (6 - (four_fingers and 1 or 0)) then
                        table.insert(ret, t)
                        return ret
                    end
                end
                return {}
            end
        end
    end
}

SMODS.PokerHandPart {
    key = 's_straight',
    func = function(hand)
        if G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger' then
            local ret = {}
            local four_fingers = next(find_joker('Four Fingers'))
            if #hand > 6 or #hand < (6 - (four_fingers and 1 or 0)) then
                return ret
            else
                local t = {}
                local IDS = {}
                for i = 1, #hand do
                    local id = hand[i]:get_id()
                    if id > 1 and id < 15 then
                        if IDS[id] then
                            IDS[id][#IDS[id] + 1] = hand[i]
                        else
                            IDS[id] = { hand[i] }
                        end
                    end
                end

                local straight_length = 0
                local straight = false
                local can_skip = next(find_joker('Shortcut'))
                local skipped_rank = false
                for j = 1, 14 do
                    if IDS[j == 1 and 14 or j] then
                        straight_length = straight_length + 1
                        skipped_rank = false
                        for k, v in ipairs(IDS[j == 1 and 14 or j]) do
                            t[#t + 1] = v
                        end
                    elseif can_skip and not skipped_rank and j ~= 14 then
                        skipped_rank = true
                    else
                        straight_length = 0
                        skipped_rank = false
                        if not straight then t = {} end
                        if straight then break end
                    end
                    if straight_length >= (6 - (four_fingers and 1 or 0)) then straight = true end
                end
                if not straight then return ret end
                table.insert(ret, t)
                return ret
            end
        end
    end
}

--endregion

--region Hand Types

SMODS.PokerHand { --Three Pair
    key = 'three_pair',
    mult = 4,
    chips = 30,
    l_mult = 1,
    l_chips = 25,
    example = {

        { 'S_K', true },
        { 'D_K', true },
        { 'S_9', true },
        { 'D_9', true },
        { 'S_6', true },
        { 'D_6', true }

    },
    loc_txt = {
        name = 'Three Pair',
        description = {
            "3 Pairs of cards with different ranks"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._2 >= 3 and parts._all_pairs or {}
    end
}

SMODS.PokerHand { --Double Triple
    key = 'double_triple',
    mult = 6,
    chips = 60,
    l_mult = 2,
    l_chips = 35,
    example = {

        { 'S_K', true },
        { 'D_K', true },
        { 'C_K', true },
        { 'S_9', true },
        { 'D_9', true },
        { 'C_9', true }

    },
    loc_txt = {
        name = 'Double Triple',
        description = {
            "Two 3 of a Kinds"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._3 >= 2 and parts._all_pairs or {}
    end
}

SMODS.PokerHand { --Six of a Kind
    key = '6oak',
    mult = 18,
    chips = 180,
    l_mult = 4,
    l_chips = 40,
    example = {

        { 'S_K', true },
        { 'D_K', true },
        { 'C_K', true },
        { 'H_K', true },
        { 'S_K', true },
        { 'D_K', true }

    },
    loc_txt = {
        name = 'Six of a Kind',
        description = {
            "6 cards with the same rank"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_6) and parts.mxms_6 or {}
    end
}

SMODS.PokerHand { --Super Straight
    key = 's_straight',
    mult = 6,
    chips = 50,
    l_mult = 3,
    l_chips = 50,
    example = {

        { 'S_A', true },
        { 'D_K', true },
        { 'C_Q', true },
        { 'H_J', true },
        { 'S_T', true },
        { 'D_9', true }

    },
    loc_txt = {
        name = 'Super Straight',
        description = {
            "6 cards in a row (consecutive ranks)"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_s_straight) and parts.mxms_s_straight or {}
    end
}

SMODS.PokerHand { --Super Flush
    key = 's_flush',
    mult = 6,
    chips = 55,
    l_mult = 2,
    l_chips = 25,
    example = {

        { 'S_A', true },
        { 'S_K', true },
        { 'S_J', true },
        { 'S_8', true },
        { 'S_6', true },
        { 'S_2', true }

    },
    loc_txt = {
        name = 'Super Flush',
        description = {
            "6 cards that share the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_s_flush) and parts.mxms_s_flush or {}
    end
}

SMODS.PokerHand { --House Party
    key = 'house_party',
    mult = 8,
    chips = 70,
    l_mult = 3,
    l_chips = 40,
    example = {

        { 'S_A', true },
        { 'D_A', true },
        { 'C_A', true },
        { 'H_A', true },
        { 'S_T', true },
        { 'D_T', true }

    },
    loc_txt = {
        name = 'House Party',
        description = {
            "A 4 of a kind and a Pair"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if #parts._4 < 1 or #parts._2 < 2 then return {} end
        return #hand >= 6 and next(parts._2) and next(parts._4) and
            { SMODS.merge_lists(parts._all_pairs) } or {}
    end
}

SMODS.PokerHand { --Flush Three Pair
    key = 'f_three_pair',
    mult = 14,
    chips = 150,
    l_mult = 3,
    l_chips = 30,
    example = {

        { 'S_K', true },
        { 'S_K', true },
        { 'S_9', true },
        { 'S_9', true },
        { 'S_6', true },
        { 'S_6', true }

    },
    loc_txt = {
        name = 'Flush Three Pair',
        description = {
            "3 Pairs of cards with different ranks with",
            "all cards sharing the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._2 == 3 and next(parts.mxms_s_flush) and
            { SMODS.merge_lists(parts._all_pairs, parts.mxms_s_flush) } or {}
    end
}

SMODS.PokerHand { --Flush Double Triple
    key = 'f_double_triple',
    mult = 16,
    chips = 170,
    l_mult = 4,
    l_chips = 50,
    example = {

        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_9', true },
        { 'S_9', true },
        { 'S_9', true }

    },
    loc_txt = {
        name = 'Flush Double Triple',
        description = {
            "Two 3 of a Kinds with",
            "all cards sharing the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._3 >= 2 and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts._all_pairs, parts.mxms_s_flush) } or {}
    end
}

SMODS.PokerHand { --Super Straight Flush
    key = 's_straight_f',
    mult = 20,
    chips = 200,
    l_mult = 5,
    l_chips = 55,
    example = {

        { 'S_A', true },
        { 'S_K', true },
        { 'S_Q', true },
        { 'S_J', true },
        { 'S_T', true },
        { 'S_9', true }

    },
    loc_txt = {
        name = 'Super Straight Flush',
        description = {
            "A 4 of a kind and a Pair with",
            "all cards sharing the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_s_straight) and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts.mxms_s_straight, parts.mxms_s_flush) } or {}
    end
}

SMODS.PokerHand { --Flush Party
    key = 'f_party',
    mult = 16,
    chips = 180,
    l_mult = 4,
    l_chips = 50,
    example = {

        { 'S_A', true },
        { 'S_A', true },
        { 'S_A', true },
        { 'S_A', true },
        { 'S_T', true },
        { 'S_T', true }

    },
    loc_txt = {
        name = 'Flush Party',
        description = {
            "6 cards in a row (consecutive ranks) with",
            "all cards sharing the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if #parts._4 < 1 or #parts._2 < 2 then return {} end
        return #hand >= 6 and next(parts._2) and next(parts._4) and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts._all_pairs, parts.mxms_s_flush) } or {}
    end
}

SMODS.PokerHand { --Flush Six
    key = 'f_6oak',
    mult = 22,
    chips = 220,
    l_mult = 5,
    l_chips = 50,
    example = {

        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true }

    },
    loc_txt = {
        name = 'Flush Six',
        description = {
            "6 cards with the same rank with",
            "all cards sharing the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_6) and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts.mxms_6, parts.mxms_s_flush) } or {}
    end
}

--endregion

--region Consumables

SMODS.Consumable { -- Microscopii
    key = 'microscopii',
    set = 'Planet',
    loc_txt = {
        name = 'Microscopii',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        hand_type = 'mxms_three_pair',
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Wasp
    key = 'wasp',
    set = 'Planet',
    loc_txt = {
        name = 'Wasp',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 0
    },
    config = {
        hand_type = 'mxms_double_triple'
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Pegasi
    key = 'pegasi',
    set = 'Planet',
    loc_txt = {
        name = 'Pegasi',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 2,
        y = 0
    },
    config = {
        hand_type = 'mxms_6oak',
        softlock = true
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Trappist
    key = 'trappist',
    set = 'Planet',
    loc_txt = {
        name = 'Trappist',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 3,
        y = 0
    },
    config = {
        hand_type = 'mxms_s_straight'
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Corot
    key = 'corot',
    set = 'Planet',
    loc_txt = {
        name = 'Corot',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 4,
        y = 0
    },
    config = {
        hand_type = 'mxms_s_flush'
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Poltergeist
    key = 'poltergeist',
    set = 'Planet',
    loc_txt = {
        name = 'Poltergeist',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 5,
        y = 0
    },
    config = {
        hand_type = 'mxms_house_party'
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Gliese
    key = 'gliese',
    set = 'Planet',
    loc_txt = {
        name = 'Gliese',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 6,
        y = 0
    },
    config = {
        hand_type = 'mxms_f_three_pair',
        softlock = true
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Cancri
    key = 'cancri',
    set = 'Planet',
    loc_txt = {
        name = 'Cancri',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 7,
        y = 0
    },
    config = {
        hand_type = 'mxms_f_double_triple',
        softlock = true
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Proxima Centauri
    key = 'proxima',
    set = 'Planet',
    loc_txt = {
        name = 'Proxima Centauri',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 8,
        y = 0
    },
    config = {
        hand_type = 'mxms_s_straight_f'
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { -- Phobetor
    key = 'phobetor',
    set = 'Planet',
    loc_txt = {
        name = 'Phobetor',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 9,
        y = 0
    },
    config = {
        hand_type = 'mxms_f_party',
        softlock = true
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

SMODS.Consumable { --Kepler
    key = 'kepler',
    set = 'Planet',
    loc_txt = {
        name = 'Kepler',
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 0,
        y = 1
    },
    config = {
        hand_type = 'mxms_f_6oak',
        softlock = true
    },
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars =
            {
                G.GAME.hands[center.ability.hand_type].level,
                localize(center.ability.hand_type, "poker_hands"),
                G.GAME.hands[center.ability.hand_type].l_mult,
                G.GAME.hands[center.ability.hand_type].l_chips,
                colours = {
                    (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                }
            },
        }
    end,
    in_pool = function(self, args)
        if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
            return true
        end

        return false
    end
}

--endregion

--region Blinds

SMODS.Blind { --The Rot
    key = 'rot',
    loc_txt = {
        name = 'The Rot',
        text = { '1/4 of cards in deck', 'are debuffed at random' }
    },
    boss = {
        min = 1,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 0
    },
    boss_colour = HEX('A2CA4C'),
    set_blind = function(self)
        for i = 1, #G.playing_cards / 4 do
            local card = G.playing_cards[pseudorandom(pseudoseed('rotcard' .. i), 1, #G.playing_cards)]
            local j = 1
            while card.debuffed_by_blind do
                card = G.playing_cards[pseudorandom(pseudoseed('rotcard_reroll' .. j), 1, #G.playing_cards)]
                j = j + 1
            end
            card.debuffed_by_blind = true
        end
    end,
    recalc_debuff = function(self, card, from_blind)
        if card.debuffed_by_blind then
            return true
        else
            return false
        end
    end,
    disable = function(self)
        for k, v in pairs(G.playing_cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end,
    defeat = function(self)
        for k, v in pairs(G.playing_cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end
}

SMODS.Blind { --The Grinder
    key = 'grinder',
    loc_txt = {
        name = 'The Grinder',
        text = { 'Enhancements, Seals, and Editions of', 'scored cards are removed after scoring' }
    },
    boss = {
        min = 1,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 1
    },
    boss_colour = HEX('D9638D'),
    after_scoring = function(self)
        for k, v in ipairs(G.play.cards) do
            if v.ability.set == 'Enhanced' or v.seal or v.edition then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        v:set_ability(G.P_CENTERS.c_base)
                        v:set_seal(nil, nil, true)
                        v:set_edition(nil, true)
                        v:juice_up(0.3, 0.4)
                        play_sound('tarot2')
                        return true
                    end
                }))
                card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Grinded' })
            end
        end
    end
}

-- after_scoring hook; derived from Ortalab
local draw_discard = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
    local obj = G.GAME.blind.config.blind
    if obj.after_scoring and not G.GAME.blind.disabled then
        obj:after_scoring()
    end
    draw_discard(e)
end

--endregion
