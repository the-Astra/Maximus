SMODS.Consumable {
    key = 'libra',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 6,
        y = 1
    },
    config = {
        extra = {
            money_spent = 0,
            goal = 15
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
        info_queue[#info_queue + 1] = G.P_TAGS['tag_mxms_scale']
        return { vars = { stg.goal, stg.money_spent } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.buying_card or context.open_booster or context.reroll_shop then
            if context.buying_card or context.open_booster then
                stg.money_spent = stg.money_spent + context.card.cost
            elseif context.reroll_shop then
                stg.money_spent = stg.money_spent + context.cost
            end

            SMODS.calculate_effect({ message = stg.money_spent .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE },
                card)

            if stg.money_spent >= stg.goal then
                self:succeed(card)
            end
        end

        if context.ending_shop then
            self:fail(card)
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return G.GAME.zodiac_killer_pools["Libra"]
        end
        return true
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
            func = (function()
                add_tag(Tag('tag_mxms_scale'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end)
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        G.GAME.zodiac_killer_pools["Libra"] = false
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
            stg.money_spent = 0
        end
        SMODS.calculate_context({ mxms_failed_horoscope = true })
    end
}
