SMODS.Consumable {
    key = 'virgo',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 5,
        y = 1
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_mxms_maiden']
        local ceiling = G.GAME.blind and to_big(G.GAME.blind.chips) * 1.25 or 0
        return { vars = { ceiling } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            if to_big(G.GAME.blind.chips) / to_big(G.GAME.chips) >= to_big(0.75) then
                self:succeed(card)
            else
                self:fail(card)
            end
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return G.GAME.zodiac_killer_pools["Virgo"]
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
                add_tag(Tag('tag_mxms_maiden'))
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
        G.GAME.zodiac_killer_pools["Virgo"] = false
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
