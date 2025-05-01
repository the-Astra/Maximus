SMODS.Joker {
    key = 'stop_sign',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 6
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
