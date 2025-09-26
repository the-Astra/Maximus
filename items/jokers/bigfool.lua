SMODS.Joker {
    key = 'bigfool',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            prob = 1,
            odds = 10
        }
    },
    mxms_credits = {
        art = { "???" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { SMODS.get_probability_vars(card, stg.prob, stg.odds, 'bigfool') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.end_of_round and not context.individual and not context.repetition then
            if SMODS.pseudorandom_probability(card, 'bigfool', stg.prob, stg.odds) then
                local conspiracies = {}
                for k, v in pairs(G.consumeables.cards) do
                    if v.ability.set == 'Conspiracy' and not v.edition and not v.marked_by_bigfool then
                        conspiracies[#conspiracies + 1] = v
                    end
                end

                if next(conspiracies) then
                    local chosen_card = pseudorandom_element(conspiracies, pseudoseed('bigfool'))
                    chosen_card.marked_by_bigfool = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up()
                            chosen_card:set_edition({ negative = true })
                            chosen_card.marked_by_bigfool = nil
                            return true;
                        end
                    }))
                end
            end
        end
    end
}
