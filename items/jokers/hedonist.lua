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
            Xmult = 1
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.Xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = "X" .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.ending_shop and #G.shop_vouchers.cards == 0 and #G.shop_booster.cards == 0 and #G.shop_jokers.cards == 0 and not context.blueprint then
            card:juice_up(0.3, 0.4)
            play_sound('tarot1')
            card.ability.extra.Xmult = card:scale_value(card.ability.extra.Xmult, 0.25)
        end
    end
}