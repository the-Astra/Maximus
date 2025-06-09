SMODS.Joker {
    key = 'normal',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 1
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    discovered = true,
    order = 2,
    rarity = 1,
    blueprint_compat = true,
    cost = 3,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.other_card.edition and not context.other_card.seal and not next(SMODS.get_enhancements(context.other_card)) then
                return {
                    mult = 2,
                    chips = 15,
                    card = card
                }
            end
        end
    end,
}
