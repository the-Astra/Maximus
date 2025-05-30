SMODS.Joker {
    key = 'coronation',
    loc_txt = {
        name = 'Coronation',
        text = { 'If {C:attention}Joker{} is in hand after', '{C:attention}#2# rounds{} without skipping,', 'upgrade {C:attention}Joker{} to {C:attention}Crowned Joker{}', '{C:inactive}Currently: #1#/#2#' }
    },
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
    blueprint_compat = false,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.j_mxms_crowned
        return { vars = { stg.rounds, stg.goal } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and next(SMODS.find_card('j_joker')) then

            stg.rounds = stg.rounds  + 1
            SMODS.calculate_effect({ message = stg.rounds .. '/3', colour = G.C.YELLOW },card)

            if stg.rounds == stg.goal then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local jimbo = SMODS.find_card('j_joker')[1]

                        local new_jimbo = SMODS.add_card({
                            set = 'Joker',
                            key = 'j_mxms_crowned',
                            key_append = 'coron'
                        })

                        if jimbo.edition then
                            new_jimbo:set_edition(jimbo.edition, nil, true)
                        end

                        jimbo:start_dissolve({ G.C.YELLOW }, nil, 1.6)

                        return true;
                    end
                }))

                stg.rounds = 0

                return {
                    sound = 'polychrome1',
                    message = 'Crowned',
                    colour = G.C.YELLOW,
                    card = card
                }
            end
        end

        if context.skip_blind and not context.blueprint and next(SMODS.find_card('j_joker')) then
            stg.rounds = 0
            return {
                message = localize('k_reset'),
                colour = G.C.YELLOW,
                card = card
            }
        end
    end,
    in_pool = function(self, args)
        return next(SMODS.find_card('j_joker'))
    end
}
