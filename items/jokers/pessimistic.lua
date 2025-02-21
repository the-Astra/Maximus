SMODS.Joker {
    key = 'pessimistic',
    loc_txt = {
        name = 'Pessimistic Joker',
        text = { 'After each failed probability check,', 'this Joker gains {C:mult}Mult{} equal to the',
            'odds of failing the check', '{C:inactive}+3 for missed Lucky Card',
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
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.individual and context.other_card.ability.effect == 'Lucky Card' and not context.after and not context.end_of_round and
            not context.other_card.lucky_trigger and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + 3
            card:juice_up(0.3, 0.4)
        end
    end
}