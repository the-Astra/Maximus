if Maximus_config.horoscopes then
    SMODS.Voucher {
        key = 'multitask',
        atlas = 'Vouchers',
        pos = {
            x = 3,
            y = 0
        },
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        redeem = function(self, card, from_debuff)
            G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + 1
        end
    }
else
    sendDebugMessage("Multitask not loaded; Horoscopes Disabled", 'Maximus')
end
