SMODS.Consumable {
    key = 'aquarius',
    set = 'Horoscope',
    loc_txt = {
        name = 'Aquarius',
        text = { 'Use {C:attention}#1#{} {C:planet}Planet{} cards', 'within the ante', 'to receive a {C:spectral}Black Hole{}', '{C:inactive}Currently: #2#/#1#' }
    },
    atlas = 'Consumables',
    pos = {
        x = 10,
        y = 1
    },
    config = {
        extra = {
            tally = 0,
            goal = 10
        }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_black_hole
        return { vars = { stg.goal, stg.tally } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            stg.tally = stg.tally + 1
            SMODS.calculate_effect({ message = stg.tally .. "/" .. stg.goal, colour = G.C.HOROSCOPE }, card)

            if stg.tally >= stg.goal then
                self:succeed(card)
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
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
            return zodiac_killer_pools["Aquarius"]
        end
        return true
    end,
    succeed = function(self, card)
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            SMODS.calculate_effect({ message = "Success!", colour = G.C.GREEN, sound = 'tarot1' }, card)
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.4)

                    SMODS.add_card({
                        set = 'Spectral',
                        key = 'c_black_hole',
                        key_append = 'aqu'
                    })
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                    return true;
                end
            }))
            zodiac_killer_pools["Aquarius"] = false
            SMODS.calculate_context({beat_horoscope = true})
        end
        G.E_MANAGER:add_event(Event({
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
