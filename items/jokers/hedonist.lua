SMODS.Joker {
    key = 'hedonist',
    loc_txt = {
        name = 'Hedonist',
        text = { '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X0.25{} Mult', 'if shop is cleared out', 'when exiting' }
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
            card:juice_up(0.3, 0.4)
            play_sound('tarot1')
            stg.Xmult = card:scale_value(stg.Xmult, stg.gain)
        end
    end
}
