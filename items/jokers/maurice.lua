SMODS.Joker {
    key = 'maurice',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 17
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" },
        reference = { "Steve Miller Band" }
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    end
}
