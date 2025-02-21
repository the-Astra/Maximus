SMODS.Joker {
    key = 'go_fish',
    loc_txt = {
        name = 'Go Fish',
        text = { '{C:mult}+2{} Mult for each {C:attention}#1#{}', 'in full deck at start of round',
            '{C:inactive}Rank changes every round', '{C:inactive}Currently {C:mult}+#2# {C:inactive}Mult' }
    },
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
                mult_mod = G.GAME.current_round.go_fish.mult,
                message = '+' .. G.GAME.current_round.go_fish.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
