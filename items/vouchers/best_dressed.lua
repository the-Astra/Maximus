SMODS.Voucher {
    key = 'best_dressed',
    loc_txt = {
        name = 'Best Dressed',
        text = { 'Suit-Changing {C:tarot}Tarot{} cards in', 'your {C:attention}consumable{} area give', '{X:mult,C:white}X1{} Mult plus {X:red,C:white}X#1#{}', 'for each {C:attention}played card{}', 'matching its suit' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = 0.2
    },
    requires = { 'v_mxms_sharp_suit' },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra }
        }
    end,
    calculate = function(self, card, context)
        if context.other_consumeable and context.other_consumeable.ability.set == 'Tarot' and context.other_consumeable.ability.consumeable.suit_conv then
            local suit_tally = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit(context.other_consumeable.ability.consumeable.suit_conv, false) then
                    suit_tally = suit_tally + 1
                end
            end
            if suit_tally > 0 then
                return {
                    x_mult = card.ability.extra * suit_tally + 1
                }
            end
        end
    end,
}