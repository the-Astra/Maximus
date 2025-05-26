SMODS.Joker {
    key = 'spare_tire',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 15
    },
    rarity = 1,
    config = {
        extra = {
            prob = 1,
            odds = 2
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "pinkzigzagoon"
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return {
            vars = { stg.prob * G.GAME.probabilities.normal, stg.odds }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.failed_prob and context.card.config.center.key == 'c_wheel_of_fortune'
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if pseudorandom('tire') < (stg.prob * G.GAME.probabilities.normal) / stg.odds then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        SMODS.add_card({ key = 'c_wheel_of_fortune' })
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true;
                    end
                }))
            else
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.FILTER,
                    func = function()
                        SMODS.calculate_context({ failed_prob = true, odds = stg.odds -
                        (stg.prob * G.GAME.probabilities.normal), card = card })
                    end
                }
            end
        end
    end
}
