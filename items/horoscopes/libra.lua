SMODS.Consumable {
    key = 'libra',
    set = 'Horoscope',
    loc_txt = {
        name = 'Libra',
        text = { 'Spend at least {C:money}$15{} during the', 'next shop to make the next', 'shop\'s offerings {C:money}free{}', '{C:inactive}Currently: #2#/#1#' }
    },
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
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.goal, stg.money_spent } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.buying_card or context.open_booster then
            stg.money_spent = stg.money_spent + context.card.cost
            SMODS.calculate_effect({ message = stg.money_spent .. "/" .. stg.goal, colour = G.C.HOROSCOPE },
                card)
            if stg.money_spent >= stg.goal then
                self:succeed(card)
            end
        end

        if context.reroll_shop then
            stg.money_spent = stg.money_spent + G.GAME.current_round.reroll_cost
            SMODS.calculate_effect({ message = stg.money_spent .. "/" .. stg.goal, colour = G.C.HOROSCOPE },
                card)
            if stg.money_spent >= stg.goal then
                self:succeed(card)
            end
        end

        if context.ending_shop then
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
            return zodiac_killer_pools["Libra"]
        end
        return true
    end,
    succeed = function(self, card)
        G.GAME.libra_bonus = true
        SMODS.calculate_effect({ message = "Success!", colour = G.C.GREEN, sound = 'tarot1' }, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
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
