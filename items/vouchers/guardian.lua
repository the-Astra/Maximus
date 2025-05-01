SMODS.Voucher {
    key = 'guardian',
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 1
    },
    requires = { 'v_mxms_shield' },
    redeem = function(self, card, from_debuff)
        G.GAME.v_destroy_reduction = G.GAME.v_destroy_reduction + 1
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
