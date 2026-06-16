-- List of cards whose probability results should be treated as the opposite
Maximus.invert_prob_cards = {
    j_gros_michel = true,
    j_cavendish = true,
    j_mxms_hugo = true,
    j_mxms_jestcoin = true,
    c_ankh = true,
    c_hex = true,
    m_glass = true
}

---Generalized Horoscope-related Tag apply func
function Maximus.activate_horoscope_tag(tag)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            tag.config.active = true
            attention_text({
                text = '+',
                colour = G.C.WHITE,
                scale = 1,
                hold = 0.3 / G.SETTINGS.GAMESPEED,
                cover = tag.HUD_tag,
                cover_colour = Maximus.C.SET.Horoscope,
                align = 'cm',
            })

            tag.pos.y = tag.pos.y + 1
            tag:juice_up(0.3, 0.4)
            play_sound('foil1', 1.2 + math.random() * 0.1, 0.4)
            return true;
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.7
    }))
end

---Checks if a card should have an inverted check when evaluating prob results
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
        local proto = G.P_CENTERS[v] or v
        if proto.mod and 'Maximus' == proto.mod.id and not proto.no_collection then
            if set then
                if proto.set and proto.set == set then
                    obj_tally.of = obj_tally.of + 1
                    if proto.discovered then
                        obj_tally.tally = obj_tally.tally + 1
                    end
                end
            else
                obj_tally.of = obj_tally.of + 1
                if proto.discovered then
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

---Counts all held Conspiracy Cards
function Maximus.count_conspiracy_cards()
    local count = 0
    if G.consumeables then
        for k, v in pairs(G.consumeables.cards) do
            if v.ability.set == 'Conspiracy' then
                count = count + 1
            end
        end
    end
    return count
end

-- Thank you for this notmario you have saved so much time
Maximus.key_has_attribute = function (card_key, key)
    if type(card_key) ~= 'string' then return false end
    local pool = SMODS.get_attribute_pool(key)
    for _, c in pairs(pool) do
        if c == card_key then return true end
    end
    return false
end

---Generalized Horoscope succeed func
Maximus.horoscope_succeed = function(card)
    card.succeeded = true
    if PlayLog then PlayLog.log({type = 'mxms_horoscope_success', card = card}) end
    card.config.center:succeed(card)
    G.GAME.zodiac_killer_pools[card.config.center_key] = false
    SMODS.calculate_context({ mxms_beat_horoscope = true })
    G.E_MANAGER:add_event(Event({
        func = function()
            card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
            return true
        end
    }))
end

---Generalized Horoscope fail func
Maximus.horoscope_fail = function(card)
    if not card.succeeded then
        if PlayLog then PlayLog.log({type = 'mxms_horoscope_fail', card = card}) end
        card.config.center:fail(card)
        if not next(SMODS.find_card('j_mxms_cheat_day')) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                    return true
                end
            }))
        elseif card.config.center.reset then
            card.config.center:reset(card)
        end
        SMODS.calculate_context({ mxms_failed_horoscope = true })
    end
end

-- Maximus custom card areas
Maximus.custom_card_areas = function(game)
    game.mxms_horoscope_W = G.CARD_W * 1.1
    game.mxms_horoscope_H = 0.95 * G.CARD_H

    game.mxms_horoscope = CardArea(
        G.consumeables.T.x + 2.25,
        G.consumeables.T.y + G.consumeables.T.h + 1,
        game.mxms_horoscope_W,
        game.mxms_horoscope_H,
        { card_limit = 1, type = 'joker', highlight_limit = 1, align_buttons = true }
    )

    if TheFamily or not Maximus_config.horoscopes then
        game.mxms_horoscope.states.visible = false
    end
end

-- Global calculates for Horoscope resetting and and Horoscope tag application
Maximus.calculate = function(self, context)
    if context.ante_change and context.ante_end then
        for i = 1, #G.GAME.tags do
            G.GAME.tags[i]:apply_to_run({ type = 'reset_horoscopes' })
        end
        for i = 1, #G.GAME.tags do
            G.GAME.tags[i]:apply_to_run({ type = 'start_apply_horoscopes' })
        end
    end

    if context.setting_blind and G.GAME.mxms_aries_bonus > 1 then
        return {
            xblind_size = 1 / G.GAME.mxms_aries_bonus
        }
    end
end

-- Horoscope toggle callback
function G.FUNCS.mxms_toggle_horoscopes(e)
    if e and G.mxms_horoscope then
        G.mxms_horoscope.states.visible = true
    elseif not e and G.mxms_horoscope then
        G.mxms_horoscope.states.visible = false
    end
end

-- Conspiracy toggle callback
function G.FUNCS.mxms_toggle_conspiracies(e)
    if e then
        G.GAME.conspiracy_rate = 1
    elseif not e then
        G.GAME.conspiracy_rate = 0
    end
end

-- Round Changing Variables
function Maximus.reset_game_globals(run_start)
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
    G.GAME.current_round.mxms_jello_suit = pseudorandom_element(jello_suits, pseudoseed('jel' .. G.GAME.round_resets.ante))
end

G.FUNCS.mxms_discord = function(e)
    love.system.openURL("https://discord.gg/GvCCcryM48")
end

Maximus.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, vars = { elements = { SMODS.create_sprite(0, 0, 6.6, 6.6 * (G.ASSET_ATLAS["mxms_logo"].py / G.ASSET_ATLAS["mxms_logo"].px), "mxms_logo", {x = 0, y = 0}) } } }
end

function Maximus.calculate_blackjack_value(hand)
    local hand_value = 0

    -- Initial pass
    for _, v in pairs(hand) do
        local card_value = v.base.nominal
        if not SMODS.has_no_rank(v) and not v.debuff then
            hand_value = hand_value + card_value
        end
    end

    -- Dynamic Ace card demoting
    -- If there are aces in hand and we are over 21, start demoting Aces to try to get under or equal to 21
    if hand_value > 21 then
        for _, v in pairs(hand) do
            if v:get_id() == 14 and not v.debuff then
                hand_value = hand_value - 10
                if hand_value <= 21 then break end -- If hand no longer exceeds 21, we no longer need to demote
            end
        end
    end

    return hand_value
end

function Maximus.poll_conspiracy_chance(card, odds, seed)
    local consp_count = Maximus.count_conspiracy_cards() + 1

    if SMODS.pseudorandom_probability(card, seed, consp_count, odds) then
        return true
    else
        G.E_MANAGER:add_event(Event({
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4); return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return true;
            end
        }))
    end
end