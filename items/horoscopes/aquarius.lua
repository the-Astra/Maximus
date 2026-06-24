SMODS.Consumable {
    key = 'aquarius',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 10,
        y = 1
    },
    config = {
        extra = {
            tally = 0,
            goal = 6
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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
            SMODS.calculate_effect({ message = stg.tally .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
            if PlayLog then PlayLog.log({ type = 'mxms_horoscope_increment', card = card, tally = stg.tally }) end

            if stg.tally >= stg.goal then
                Maximus.horoscope_succeed(card)
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
            Maximus.horoscope_fail(card)
        end
    end,
    succeed = function(self, card)
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
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
                G.GAME.consumeable_buffer = 0
                return true;
            end
        }))
    end,
    reset = function(self, card)
        card.ability.extra.tally = 0
    end,
    can_use = function(self, card) return false end,
    can_succeed = function(self, card) return #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit end
}
