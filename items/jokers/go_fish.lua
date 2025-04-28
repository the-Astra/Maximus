SMODS.Joker {
    key = 'go_fish',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 4
    },
    rarity = 1,
    config = {},
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { G.GAME.current_round.go_fish.rank, G.GAME.current_round.go_fish.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = G.GAME.current_round.go_fish.mult
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
