SMODS.Joker {
    key = 'maurice',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    credit = {
        art = "anerdymous",
        code = "theAstra",
        concept = "anerdymous"
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    end
}
