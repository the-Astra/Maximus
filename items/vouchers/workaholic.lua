SMODS.Voucher {
    key = 'workaholic',
    loc_txt = {
        name = 'Workaholic',
        text = { 
            '{C:attention}+1{} horoscope slot' 
        }
    },
    atlas = 'Vouchers',
    pos = {
        x = 3,
        y = 1
    },
    redeem = function(self, card, from_debuff)
        G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + 1
    end
}
