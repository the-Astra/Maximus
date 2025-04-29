SMODS.Joker {
    key = 'maurice',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': anerdymous', G.C.BLACK, G.C.WHITE, 1)
    end
}
