SMODS.Joker {
    key = 'virus',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 3
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
