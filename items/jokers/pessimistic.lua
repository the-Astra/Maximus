SMODS.Joker {
    key = 'pessimistic',
    loc_txt = {
        name = 'Pessimistic Joker',
        text = { 'After each failed probability check,', 'this Joker gains {C:mult}Mult{} equal to the',
            'odds of failing the check', '{s:0.8,C:inactive}+#2# for missed Lucky Card',
            '{C:inactive}Currently: {C:mult}+#1# {C:inactive}Mult' }
    },
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
                mult_mod = stg.mult,
                message = '+' .. stg.mult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.individual and context.other_card.ability.effect == 'Lucky Card' and not context.after and not context.end_of_round and
            not context.other_card.lucky_trigger and not context.blueprint then
            stg.mult = stg.mult + card.ability.extra.lucky_gain
            card:juice_up(0.3, 0.4)
        end
    end
}
