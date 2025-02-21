SMODS.Voucher {
    key = 'shield',
    loc_txt = {
        name = 'Shield',
        text = { '{C:spectral}Spectral{} cards that destroy Jokers', 'only have a {C:green}1 in 2{} chance', 'to destroy each Joker' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 0
    },
    redeem = function(self, card, from_debuff)
        G.GAME.v_destroy_reduction = G.GAME.v_destroy_reduction + 1
    end
}