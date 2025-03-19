SMODS.Joker {
    key = 'combo_breaker',
    loc_txt = {
        name = 'Combo Breaker',
        text = { 'Gains {X:mult,C:white}X#1#{} Mult', 'per retrigger',
            '{s:0.8,C:inactive}Starts at {s:0.8,X:mult,C:white}X1{s:0.8,C:inactive} Mult, resets every hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 1
    },
    rarity = 3,
    config = {
        extra = {
            gain = 0.5,
            retriggers = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain }
        }
    end,

    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.post_trigger and context.other_context.retrigger_joker then
            -- Add retrigger to total
            stg.retriggers = stg.retriggers + 1
            return {
                card = card
            }
        end

        if context.joker_main and stg.retriggers > 0 then
            return {
                sound = 'mxms_perfect',
                Xmult_mod = stg.retriggers * stg.gain + 1,
                message = 'X' .. stg.retriggers * stg.gain + 1,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before or context.after then
            stg.retriggers = 0
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
