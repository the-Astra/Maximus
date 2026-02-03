SMODS.Joker {
    key = 'ufo',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 18
    },
    rarity = 2,
    config = {
        extra = {
            multiplier = 2,
            prob = 1,
            odds = 4
        }
    },
    mxms_credits = {
        art = { "GhostSalt" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.multiplier, SMODS.get_probability_vars(card, stg.prob, stg.odds, 'ufo') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.mod_probability and context.trigger_obj.ability and context.trigger_obj.ability.set == 'Conspiracy' then
            return {
                numerator = context.numerator * stg.multiplier
            }
        end

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'ufo', stg.prob, stg.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve()
                        return true;
                    end
                }))
                return {
                    message = localize('k_cspy_covered_up')
                }
            else
                return {
                    message = localize('k_saved_ex')
                }
            end
        end
    end
}
