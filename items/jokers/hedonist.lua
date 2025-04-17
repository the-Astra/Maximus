SMODS.Joker {
    key = 'hedonist',
    loc_txt = {
        name = 'Hedonist',
        text = { 
            'Gains {X:mult,C:white}X#2#{} Mult', 
            'if shop is {C:attention}cleared', 
            'when {C:attention}exiting', 
            '{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 5
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.25
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.Xmult > 1 then
            return {
                Xmult_mod = stg.Xmult,
                message = "X" .. stg.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.ending_shop and #G.shop_vouchers.cards == 0 and #G.shop_booster.cards == 0 and #G.shop_jokers.cards == 0 and not context.blueprint then
            stg.Xmult = stg.Xmult + stg.gain
            SMODS.calculate_effect({ message = localize{type = 'variable', key = 'a_xmult', vars = {stg.Xmult}}},card)
            SMODS.calculate_context({scaling_card = true})
        end
    end
}
