SMODS.Joker {
    key = 'go_fish',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 4
    },
    rarity = 1,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { localize(G.GAME.current_round.mxms_go_fish.rank, 'ranks'), G.GAME.current_round.mxms_go_fish.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = G.GAME.current_round.mxms_go_fish.mult
            }
        end
    end
}
