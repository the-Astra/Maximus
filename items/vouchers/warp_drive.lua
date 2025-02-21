SMODS.Voucher {
    key = 'warp_drive',
    loc_txt = {
        name = 'Warp Drive',
        text = { '{C:attention}+#1#{} ante,', '{C:blue}+#2#{} hands and', '{C:red}+#2#{} discards', 'each round' }
    },
    atlas = 'Vouchers',
    pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = {
            ante_mod = 1,
            val_mod = 2
        }
    },
    requires = { 'v_mxms_launch_code' },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.ante_mod, center.ability.extra.val_mod }
        }
    end,
    redeem = function(self, card)
        ease_ante(card.ability.extra.ante_mod)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.ante_mod

        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.val_mod
        ease_hands_played(card.ability.extra.val_mod)

        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.val_mod
        ease_discard(card.ability.extra.val_mod)
    end,
    in_pool = function(self, args)
        if G.GAME.round_resets.ante == G.GAME.win_ante then
            return false
        end

        return true
    end
}