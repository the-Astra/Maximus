SMODS.Consumable {
    key = 'ophiucus',
    set = 'Spectral',
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 2
    },
    config = {
        hands = {
            ["Straight Flush"] = false,
            ["Four of a Kind"] = false,
            ["Full House"] = false,
            ["Flush"] = false,
            ["Straight"] = false,
            ["Three of a Kind"] = false,
            ["Two Pair"] = false,
            ["Pair"] = false,
            ["High Card"] = false,
        },
        extra = {
            antes = 0,
            ante_limit = 2,
            handtypes_played = 0
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    hidden = true,
    soul_set = 'Horoscope',
    soul_rate = 0.003,
    select_card = 'mxms_horoscope',
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
        return { vars = { stg.handtypes_played, stg.ante_limit } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability
        if context.before and not stg.hands[context.scoring_name] then
            stg.hands[context.scoring_name] = true
            stg.extra.handtypes_played = stg.extra.handtypes_played + 1
            SMODS.calculate_effect({ message = stg.extra.handtypes_played .. "/9", colour = Maximus.C.HOROSCOPE }, card)

            local all_hands = true
            for k, v in pairs(stg.hands) do
                if not v then
                    all_hands = false
                    break
                end
            end
            if all_hands then
                self:succeed(card)
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
            stg.extra.antes = stg.extra.antes + 1
            if stg.extra.antes >= stg.extra.ante_limit then
                self:fail(card)
            else
                SMODS.calculate_effect(
                    { message = stg.extra.ante_limit - stg.extra.antes .. " Ante Left...", colour = Maximus.C.HOROSCOPE },
                    card)
            end
        end
    end,
    succeed = function(self, card)
        SMODS.calculate_effect(
            {
                message = localize('k_mxms_success_ex'),
                colour = G.C.GREEN,
                sound = 'tarot1',
                func = function()
                    Maximus.set_horoscope_success(card)
                    check_for_unlock({ type = "all_horoscopes" })
                    if TheFamily then G.GAME.horoscope_alert = true end
                end
            }, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.4)

                SMODS.add_card({
                    set = 'Spectral',
                    key = 'c_soul',
                    edition = 'e_negative',
                    key_append = 'oph'
                })
                return true;
            end
        }))
        SMODS.calculate_context({ mxms_beat_horoscope = true })
        G.E_MANAGER:add_event(Event({
            func = function()
                card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
    end,
    fail = function(self, card)
        local stg = card.ability
        SMODS.calculate_effect(
            {
                message = localize('k_mxms_failed_ex'),
                colour = G.C.RED,
                sound = 'tarot2',
                func = function() if TheFamily then G.GAME.horoscope_alert = true end end
            }, card)
        if not next(SMODS.find_card('j_mxms_cheat_day')) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                    return true
                end
            }))
        else
            stg.hands = {
                ["Straight Flush"] = false,
                ["Four of a Kind"] = false,
                ["Full House"] = false,
                ["Flush"] = false,
                ["Straight"] = false,
                ["Three of a Kind"] = false,
                ["Two Pair"] = false,
                ["Pair"] = false,
                ["High Card"] = false,
            }
        end
        SMODS.calculate_context({ mxms_failed_horoscope = true })
    end,
    add_to_deck = function(self, card, from_debuff)
        local stg = card.ability
        stg.hands = {
            ["Straight Flush"] = false,
            ["Four of a Kind"] = false,
            ["Full House"] = false,
            ["Flush"] = false,
            ["Straight"] = false,
            ["Three of a Kind"] = false,
            ["Two Pair"] = false,
            ["Pair"] = false,
            ["High Card"] = false,
        }
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_horoscope'), Maximus.C.SET.Horoscope, G.C.WHITE, 1.2)
        end
    end
}
