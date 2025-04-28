SMODS.Joker {
    key = 'chekhov',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 10
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main and G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown then
            return {
                Xmult_mod = G.GAME.round_resets.blind_ante,
                message = 'x' .. G.GAME.round_resets.blind_ante,
                colour = G.C.MULT,
                card = card
            }
        end
    end,
    in_pool = function(self, args)
        if G.GAME.round_resets.blind_ante <= 4 then
            return true
        end

        return false
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
