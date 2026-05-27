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
    if type(card_key) ~= 'String' then return false end
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