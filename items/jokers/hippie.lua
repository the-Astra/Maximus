SMODS.Joker {
    key = 'hippie',
    loc_txt = {
        name = 'Hippie',
        text = { 
            'Gains {X:mult,C:white}X#2#{} Mult', 
            'after a {C:horoscope}Horoscope{} card', 
            'is fulfilled', 
            '{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 10
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.5
        }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.beat_horoscope and not context.blueprint then
            stg.Xmult = stg.Xmult + stg.gain
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_xmult', vars = { stg.Xmult } } },
                card)
            SMODS.calculate_context({scaling_card = true})
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                Xmult_mod = stg.Xmult,
                message = 'x' .. stg.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
