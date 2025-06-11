SMODS.Consumable {
    key = 'leo',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 4,
        y = 1
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_mxms_lion']
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            self:succeed(card)
        end
        if context.before and G.GAME.current_round.hands_left ~= G.GAME.round_resets.hands - 1 then
            self:fail(card)
        end

        if context.selling_self and G.GAME.modifiers.mxms_zodiac_killer then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.STATE = G.STATES.GAME_OVER
                    if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                        G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
                    end
                    G:save_settings()
                    G.FILE_HANDLER.force = true
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return zodiac_killer_pools["Leo"]
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
                    set_horoscope_success(card)
                    check_for_unlock({ type = "all_horoscopes" })
                end
            }, card)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_mxms_lion'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end)
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        zodiac_killer_pools["Leo"] = false
        SMODS.calculate_context({ beat_horoscope = true })
    end,
    fail = function(self, card)
        SMODS.calculate_effect({ message = localize('k_mxms_failed_ex'), colour = G.C.RED, sound = 'tarot2' }, card)
        if not next(SMODS.find_card('j_mxms_cheat_day')) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                    return true
                end
            }))
        end
        if G.GAME.modifiers.mxms_zodiac_killer then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.STATE = G.STATES.GAME_OVER
                    if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                        G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
                    end
                    G:save_settings()
                    G.FILE_HANDLER.force = true
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
        SMODS.calculate_context({ failed_horoscope = true })
    end
}
