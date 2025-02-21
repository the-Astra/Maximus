SMODS.Joker {
    key = 'combo_breaker',
    loc_txt = {
        name = 'Combo Breaker',
        text = { 'Gains {X:mult,C:white}X0.5{} Mult', 'per retrigger',
            '{C:inactive}Starts at {X:mult,C:white}X1{C:inactive} Mult, resets every hand{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 1
    },
    rarity = 3,
    config = {
        extra = {
            Xmult = 1.0,
            retriggers = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.Xmult, center.ability.extra.retriggers }
        }
    end,

    calculate = function(self, card, context)
        if context.post_trigger and context.other_context.retrigger_joker then
            -- Add retrigger to total
            card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            return {
                card = card
            }
        end

        if context.joker_main and card.ability.extra.retriggers > 0 then
            -- Add retrigger count and multiply by 0.5 for mult
            card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.retriggers * 0.5)

            return {
                sound = 'mxms_perfect',
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before or context.after then
            card.ability.extra.retriggers = 0
            card.ability.extra.Xmult = 1.0
        end
    end
}

-- Repetition Calc hook for Combo Breaker card repetition tracking
local rep_calc = SMODS.calculate_repetitions
function SMODS.calculate_repetitions(card, context, reps)
    local rep_return = rep_calc(card, context, reps)
    local jokers = SMODS.find_card('j_mxms_combo_breaker')
    if next(jokers) then
        for _, joker in ipairs(jokers) do
            joker.ability.extra.retriggers = joker.ability.extra.retriggers + #rep_return - 1
        end
    end
    return rep_return
end