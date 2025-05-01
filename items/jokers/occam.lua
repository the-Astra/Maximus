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
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
