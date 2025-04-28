SMODS.Joker {
    key = 'normal',
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
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
