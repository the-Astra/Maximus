SMODS.Voucher {
    key = 'warp_drive',
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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    requires = { 'v_mxms_launch_code' },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.ante_mod, stg.val_mod }
        }
    end,
    redeem = function(self, card)
        local stg = card.ability.extra
        ease_ante(stg.ante_mod)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + stg.ante_mod

        G.GAME.round_resets.hands = G.GAME.round_resets.hands + stg.val_mod
        ease_hands_played(stg.val_mod)

        G.GAME.round_resets.discards = G.GAME.round_resets.discards + stg.val_mod
        ease_discard(stg.val_mod)
    end,
    in_pool = function(self, args)
        if G.GAME.round_resets.ante == G.GAME.win_ante then
            return false
        end

        return true
    end
}
