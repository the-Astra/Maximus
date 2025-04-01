SMODS.Consumable {
    key = 'taurus',
    set = 'Horoscope',
    loc_txt = {
        name = 'Taurus',
        text = { 
            'Play the same {C:attention}hand type{}', 
            '#1# times in a row to receive', 
            '{C:attention}+#2#{} levels for that hand type', 
            '{C:inactive}Currently: #3#/#1#' 
        }
    },
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
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = G.C.HOROSCOPE }, card)
            elseif stg.hand_type == context.scoring_name then
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = G.C.HOROSCOPE }, card)
            else
                self:fail(card)
            end

            if stg.times == stg.goal then
                self:succeed(card)
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
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return zodiac_killer_pools["Taurus"]
        end
        return true
    end,
    succeed = function(self, card)
        local stg = card.ability.extra
        SMODS.calculate_effect({ message = "Success!", colour = G.C.GREEN, sound = 'tarot1' }, card)
        level_up_hand(card, stg.hand_type, false, stg.upgrade)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        zodiac_killer_pools["Taurus"] = false
        SMODS.calculate_context({beat_horoscope = true})
    end,
    fail = function(self, card)
        local stg = card.ability.extra
        SMODS.calculate_effect({ message = "Failed!", colour = G.C.RED, sound = 'tarot2' }, card)
        if not next(SMODS.find_card('j_mxms_cheat_day')) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                    return true
                end
            }))
        else
            stg.times = 0
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
        SMODS.calculate_context({failed_horoscope = true})
    end
}
