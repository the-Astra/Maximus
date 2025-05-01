SMODS.Joker {
    key = 'whos_on_first',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 13
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 4,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
