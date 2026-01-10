SMODS.Joker {
    key = 'under_construction',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 17
    },
    rarity = 3,
    config = {
        extra_slots_used = 1,
        extra = {
            rounds = 0,
            increase = 1,
            goal = 3
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.increase, stg.rounds, stg.goal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.selling_self and stg.rounds >= stg.goal and not context.blueprint then
            return {
                message = localize({type = 'variable', key = 'a_mxms_jokersize', vars = {stg.increase}}),
                func = function()
                    G.jokers:change_size(stg.increase)
                end
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and stg.rounds < stg.goal then
            stg.rounds = stg.rounds + 1
            if stg.rounds >= stg.goal then
                local eval = function(card)
                    return not card.REMOVED
                end
                juice_card_until(card, eval, true)
            end

            return {
                message = (stg.rounds < stg.goal) and (stg.rounds .. '/' .. stg.goal) or localize('k_active_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
    end
}
