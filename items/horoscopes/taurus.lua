SMODS.Consumable {
    key = 'taurus',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = {
            hand_type = nil,
            times = 0,
            goal = 3,
            upgrade = 3
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
            if not stg.hand_type then
                stg.hand_type = context.scoring_name
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
            elseif stg.hand_type == context.scoring_name then
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
            else
                self:fail(card)
            end

            if stg.times == stg.goal then
                self:succeed(card, context)
            end
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return G.GAME.zodiac_killer_pools["Taurus"]
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
        SMODS.smart_level_up_hand(card, stg.hand_type, false, stg.upgrade)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        G.GAME.zodiac_killer_pools["Taurus"] = false
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
        end
        SMODS.calculate_context({ mxms_failed_horoscope = true })
    end
}
