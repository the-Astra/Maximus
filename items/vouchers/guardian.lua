SMODS.Voucher {
    key = 'guardian',
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 1
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    requires = { 'v_mxms_shield' },
    redeem = function(self, card, from_debuff)
        G.GAME.mxms_v_destroy_reduction = G.GAME.mxms_v_destroy_reduction + 1
    end
}
