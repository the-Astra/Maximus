SMODS.Joker {
    key = 'astigmatism',
    loc_txt = {
        name = 'Astigmatism',
        text = { '{X:chips,C:white}x2{} Chips' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 0
    },
    rarity = 3,
    config = {},
    blueprint_compat = true,
    cost = 9,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xchip_mod = 2,
                message = 'x2',
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}