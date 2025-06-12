SMODS.Consumable {
    key = 'scorpio',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 7,
        y = 1
    },
    config = {
        extra = {
            hands = 0,
            goal = 4,
            upgrade = 5
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.goal, stg.upgrade, stg.hands } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before then
            if G.GAME.current_round.most_played_poker_hand == context.scoring_name then
                self:fail(card)
            else
                stg.hands = stg.hands + 1
                SMODS.calculate_effect({ message = stg.hands .. "/" .. stg.goal, colour = G.C.HOROSCOPE }, card)

                if stg.hands >= stg.goal then
                    self:succeed(card, context)
                end
            end
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
            return zodiac_killer_pools["Scorpio"]
        end
        return true
    end,
    succeed = function(self, card, context)
        local stg = card.ability.extra
        SMODS.calculate_effect(
        { message = localize('k_mxms_success_ex'), colour = G.C.GREEN, sound = 'tarot1', func = function()
            set_horoscope_success(card)
            check_for_unlock({ type = "all_horoscopes" })
        end }, card)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
                handname = G.GAME.current_round.most_played_poker_hand,
                chips = G.GAME.hands
                    [G.GAME.current_round.most_played_poker_hand].chips,
                mult = G.GAME.hands
                    [G.GAME.current_round.most_played_poker_hand].mult,
                level = G.GAME.hands
                    [G.GAME.current_round.most_played_poker_hand].level
            })
        level_up_hand(card, G.GAME.current_round.most_played_poker_hand, false, stg.upgrade)
        if context then
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                {
                    handname = context.scoring_name,
                    chips = G.GAME.hands[context.scoring_name].chips,
                    mult = G.GAME.hands
                        [context.scoring_name].mult,
                    level = G.GAME.hands[context.scoring_name].level
                })
        else
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                {
                    handname = '',
                    chips = 0,
                    mult = 0,
                    level = ''
                })
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        zodiac_killer_pools["Scorpio"] = false
        SMODS.calculate_context({ mxms_beat_horoscope = true })
    end,
    fail = function(self, card)
        local stg = card.ability.extra
        SMODS.calculate_effect({ message = localize('k_mxms_failed_ex'), colour = G.C.RED, sound = 'tarot2' }, card)
        if not next(SMODS.find_card('j_mxms_cheat_day')) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                    return true
                end
            }))
        else
            stg.hands = 0
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
        SMODS.calculate_context({ mxms_failed_horoscope = true })
    end
}
