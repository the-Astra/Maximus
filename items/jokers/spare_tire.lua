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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return {
            vars = { SMODS.get_probability_vars(card, stg.prob, stg.odds, 'tire') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.pseudorandom_result and not context.result and context.identifier == 'wheel_of_fortune'
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, 'tire', stg.prob, stg.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up()
                        SMODS.add_card({ key = 'c_wheel_of_fortune' })
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true;
                    end
                }))
            else
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}
