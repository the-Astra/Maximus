SMODS.Consumable {
    key = 'sagittarius',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 8,
        y = 1
    },
    cost = 4,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            self:succeed(card)
        end
        if context.pre_discard then
            self:fail(card)
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return G.GAME.zodiac_killer_pools["Sagittarius"]
        end
        return true
    end,
    succeed = function(self, card)
        G.GAME.mxms_sagittarius_bonus = true
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
            trigger = 'after',
            func = function()
                card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        G.GAME.zodiac_killer_pools["Sagittarius"] = false
        SMODS.calculate_context({ mxms_beat_horoscope = true })
    end,
    fail = function(self, card)
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
        end
        SMODS.calculate_context({ mxms_failed_horoscope = true })
    end
}
