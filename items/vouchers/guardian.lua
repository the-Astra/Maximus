SMODS.Voucher {
    key = 'guardian',
    loc_txt = {
        name = 'Guardian',
        text = { 
            '{C:spectral}Spectral{} cards that', 
            'destroy Jokers', 
            'no longer do so' 
        }
    },
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 1
    },
    requires = { 'v_mxms_shield' },
    redeem = function(self, card, from_debuff)
        G.GAME.v_destroy_reduction = G.GAME.v_destroy_reduction + 1
    end
}
