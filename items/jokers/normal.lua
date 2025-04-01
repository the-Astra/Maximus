SMODS.Joker {
    key = 'normal',
    loc_txt = {
        name = 'Normal Joker',
        text = { 
            'Played cards without an', 
            'enchancement, edition, or seal',
            'give {C:mult}+2{} Mult and {C:chips}+15{} Chips' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 1
    },
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
    end
}
