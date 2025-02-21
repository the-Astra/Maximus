SMODS.Joker {
    key = 'ocham',
    loc_txt = {
        name = 'Ocham\'s Razor',
        text = { '{X:mult,C:white}Xmult{} equal to', 'number of cards played plus 1', 'below max highlight limit played' }
    },
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
                Xmult_mod = G.hand.config.highlighted_limit - #context.full_hand + 1,
                message = 'x' .. G.hand.config.highlighted_limit - #context.full_hand + 1,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
