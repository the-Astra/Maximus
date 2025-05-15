SMODS.Joker {
    key = 'pessimistic',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0,
            lucky_gain = 3
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.mult, stg.lucky_gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult
            }
        end

        if context.individual and context.other_card.ability.effect == 'Lucky Card' and not context.after and not context.end_of_round and
            not context.other_card.lucky_trigger and not context.blueprint then
            stg.mult = stg.mult + card.ability.extra.lucky_gain
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:juice_up(0.3, 0.4)
                    play_sound('generic1')
                    return true
                end
            }))
            SMODS.calculate_context({ scaling_card = true })
        end

        if context.failed_prob and not context.blueprint then
            stg.mult = stg.mult + context.odds
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:juice_up(0.3, 0.4)
                    return true
                end
            }))
            SMODS.calculate_context({ scaling_card = true })
        end
    end
}
