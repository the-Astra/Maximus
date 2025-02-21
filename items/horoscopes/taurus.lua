SMODS.Consumable {
    key = 'taurus',
    set = 'Horoscope',
    loc_txt = {
        name = 'Taurus',
        text = { 'Play the same {C:attention}hand type{}', '3 times in a row to receive', '{C:attention}+3{} levels for that hand type' }
    },
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = {
            hand_type = nil,
            times = 0
        }
    },
    cost = 4,
    calculate = function(self, card, context)
        if context.before then
            if not card.ability.extra.hand_type then
                card.ability.extra.hand_type = context.scoring_name
                card.ability.extra.times = card.ability.extra.times + 1
                SMODS.calculate_effect({ message = card.ability.extra.times .. "/3", colour = G.C.HOROSCOPE }, card)
            elseif card.ability.extra.hand_type == context.scoring_name then
                card.ability.extra.times = card.ability.extra.times + 1
                SMODS.calculate_effect({ message = card.ability.extra.times .. "/3", colour = G.C.HOROSCOPE }, card)
            else
                self:fail(card)
            end

            if card.ability.extra.times == 3 then
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
        SMODS.calculate_effect({ message = "Success!", colour = G.C.GREEN, sound = 'tarot1' }, card)
        level_up_hand(card, card.ability.extra.hand_type, false, 5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        zodiac_killer_pools["Taurus"] = false
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