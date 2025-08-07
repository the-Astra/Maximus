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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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

        if context.pseudorandom_result and (not context.result and not Maximus.is_invert_prob_check(context.trigger_obj) or context.success and Maximus.is_invert_prob_check(context.trigger_obj)) and not context.blueprint then
            if context.card.ability.effect ~= 'Lucky Card' then
                stg.mult = stg.mult + (context.denominator - context.numerator)
            else
                stg.mult = stg.mult + card.ability.extra.lucky_gain
            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.ATTENTION,
                func = function() SMODS.calculate_context({ mxms_scaling_card = true }) end
            }
        end
    end
}
