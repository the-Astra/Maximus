if Maximus_config.horoscopes then
    SMODS.Voucher {
        key = 'workaholic',
        atlas = 'Vouchers',
        pos = {
            x = 3,
            y = 1
        },
        credit = {
            art = "Maxiss02",
            code = "theAstra",
            concept = "Maxiss02"
        },
        requires = { 'v_mxms_multitask' },
        redeem = function(self, card, from_debuff)
            G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + 1
        end
    }
else
    sendDebugMessage("Workaholic not loaded; Horoscopes Disabled", 'Maximus')
end
