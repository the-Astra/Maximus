if Maximus_config.horoscopes then
    SMODS.Voucher {
        key = 'multitask',
        atlas = 'Vouchers',
        pos = {
            x = 3,
            y = 0
        },
        redeem = function(self, card, from_debuff)
            G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + 1
        end,
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    }
else
    sendDebugMessage("Multitask not loaded; Horoscopes Disabled", 'Maximus')
end
