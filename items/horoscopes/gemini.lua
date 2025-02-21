SMODS.Consumable {
    key = 'gemini',
    set = 'Horoscope',
    loc_txt = {
        name = 'Gemini',
        text = { 'For the next {C:blue}#1#{} hands,', 'play {C:red}no repeat hand types{} to', 'receive {C:attention}+#2#{} levels for', 'each played hand type' }
    },
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
            upgrade = 3
        }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.goal, stg.upgrade } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before then
            if card.ability.hands[context.scoring_name] then
                self:fail(card)
            else
                card.ability.hands[context.scoring_name] = true
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = G.C.HOROSCOPE }, card)
            end

            if stg.times == stg.goal then
                self:succeed(card, context)
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
            return zodiac_killer_pools["Gemini"]
        end
        return true
    end,
    succeed = function(self, card, context)
        local stg = card.ability.extra
        SMODS.calculate_effect({ message = "Success!", colour = G.C.GREEN, sound = 'tarot1' }, card)
        for k, v in pairs(card.ability.hands) do
            if v then
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                    {
                        handname = k,
                        chips = G.GAME.hands[k].chips,
                        mult = G.GAME.hands[k].mult,
                        level = G.GAME.hands[k]
                            .level
                    })
                level_up_hand(card, k, false, stg.upgrade)
            end
        end
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
                handname = context.scoring_name,
                chips = G.GAME.hands[context.scoring_name].chips,
                mult = G.GAME.hands
                    [context.scoring_name].mult,
                level = G.GAME.hands[context.scoring_name].level
            })
        G.E_MANAGER:add_event(Event({
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        zodiac_killer_pools["Gemini"] = false
    end,
    fail = function(self, card)
        SMODS.calculate_effect({ message = "Failed!", colour = G.C.RED, sound = 'tarot2' }, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.RED }, nil, 1.6)
                return true
            end
        }))
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
    end
}
