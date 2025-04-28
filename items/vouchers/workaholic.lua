if Maximus_config.horoscopes then
    SMODS.Voucher {
        key = 'workaholic',
        atlas = 'Vouchers',
        pos = {
            x = 3,
            y = 1
        },
        requires = { 'v_mxms_multitask' },
        redeem = function(self, card, from_debuff)
            G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + 1
        end,
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    }
else
    sendDebugMessage("Workaholic not loaded; Horoscopes Disabled", 'Maximus')
end
