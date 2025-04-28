SMODS.Voucher {
    key = 'best_dressed',
    atlas = 'Vouchers',
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = 0.2
    },
    requires = { 'v_mxms_sharp_suit' },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.other_consumeable and context.other_consumeable.ability.set == 'Tarot' and context.other_consumeable.ability.consumeable.suit_conv then
            local suit_tally = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit(context.other_consumeable.ability.consumeable.suit_conv, false) then
                    suit_tally = suit_tally + 1
                end
            end
            if suit_tally > 0 then
                return {
                    x_mult = stg * suit_tally + 1
                }
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
