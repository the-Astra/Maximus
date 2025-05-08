SMODS.Joker {
    key = 'rock_candy',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 14
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
