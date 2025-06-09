SMODS.Joker {
    key = 'maurice',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 17
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
