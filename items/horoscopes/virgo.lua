SMODS.Consumable {
    key = 'virgo',
    set = 'Horoscope',
    loc_txt = {
        name = 'Virgo',
        text = { 'Defeat the next blind with a score', 'within {C:attention}25%{} of requirement to', 'receive {C:red}+3{} discards next ante' }
    },
    atlas = 'Consumables',
    pos = {
        x = 5,
        y = 1
    },
    cost = 4,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            if to_big(G.GAME.blind.chips) / to_big(G.GAME.chips) >= to_big(0.75) then
                self:succeed(card)
            else
                self:fail(card)
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
            return zodiac_killer_pools["Virgo"]
        end
        return true
    end,
    succeed = function(self, card)
        G.GAME.next_ante_horoscopes["Virgo"] = true
        SMODS.calculate_effect({ message = "Success!", colour = G.C.GREEN, sound = 'tarot1' }, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        zodiac_killer_pools["Virgo"] = false
    end,
    fail = function(self, card)
        SMODS.calculate_effect({ message = "Failed!", colour = G.C.RED, sound = 'tarot2' }, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
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
