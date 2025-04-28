SMODS.Joker {
    key = 'change',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
        }
    },
    blueprint_compat = false,
    cost = 5,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
    end
}
