SMODS.Joker {
    key = 'occam',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 9
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand ~= G.hand.config.highlighted_limit then
            return {
                x_mult = G.hand.config.highlighted_limit - #context.full_hand + 1
            }
        end
    end
}
