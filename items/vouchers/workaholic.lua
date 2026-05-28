SMODS.Voucher {
    key = 'workaholic',
    atlas = 'Vouchers',
    pos = {
        x = 3,
        y = 1
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    requires = { 'v_mxms_multitask' },
    redeem = function(self, card, from_debuff)
        G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + 1
    end,
    in_pool = function(self, args)
        return Maximus_config.horoscopes
    end
}
