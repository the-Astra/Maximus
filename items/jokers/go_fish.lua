SMODS.Joker {
    key = 'go_fish',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 4
    },
    rarity = 1,
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
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
    end
}
