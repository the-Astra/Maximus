SMODS.Joker {
    key = 'coronation',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 5
    },
    rarity = 3,
    config = {
        extra = {
            rounds = 0,
            goal = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.j_joker
        info_queue[#info_queue + 1] = G.P_CENTERS.j_mxms_crowned
        return { vars = { stg.rounds, stg.goal } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and next(SMODS.find_card('j_joker')) then
            stg.rounds = stg.rounds + 1
            SMODS.calculate_effect({ message = stg.rounds .. '/' .. stg.goal, colour = G.C.GOLD }, card)

            if stg.rounds == stg.goal then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local jimbo = SMODS.find_card('j_joker')[1]
                        jimbo:set_ability(G.P_CENTERS['j_mxms_crowned'])
                        jimbo:juice_up(0.8, 0.8)

                        check_for_unlock({ type = "crowned" })
                        return true;
                    end
                }))

                stg.rounds = 0

                return {
                    sound = 'polychrome1',
                    message = localize('k_mxms_crowned'),
                    colour = G.C.GOLD,
                    card = card
                }
            end
        end

        if context.skip_blind and not context.blueprint and next(SMODS.find_card('j_joker')) then
            stg.rounds = 0
            return {
                message = localize('k_reset'),
                colour = G.C.GOLD,
                card = card
            }
        end
    end,
    in_pool = function(self, args)
        return next(SMODS.find_card('j_joker'))
    end
}
