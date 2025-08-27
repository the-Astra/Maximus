SMODS.Consumable {
    key = 'gemini',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 2,
        y = 1
    },
    config = {
        hands = {
            ["Flush Five"] = false,
            ["Flush House"] = false,
            ["Five of a Kind"] = false,
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
            times = 0,
            goal = 3,
            upgrade = 2
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.goal, stg.upgrade, stg.times } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before then
            if card.ability.hands[context.scoring_name] then
                self:fail(card)
            else
                card.ability.hands[context.scoring_name] = true
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
            end

            if stg.times == stg.goal then
                self:succeed(card, context)
            end
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return G.GAME.zodiac_killer_pools["Gemini"]
        end
        return true
    end,
    succeed = function(self, card, context)
        local stg = card.ability.extra
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
        for k, v in pairs(card.ability.hands) do
            if v then
                SMODS.smart_level_up_hand(card, k, false, stg.upgrade)
            end
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        G.GAME.zodiac_killer_pools["Gemini"] = false
        SMODS.calculate_context({ mxms_beat_horoscope = true })
    end,
    fail = function(self, card)
        local stg = card.ability.extra
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
            stg.times = 0
            card.ability.hands = {
                ["Flush Five"] = false,
                ["Flush House"] = false,
                ["Five of a Kind"] = false,
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
    end
}
