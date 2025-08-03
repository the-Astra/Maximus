SMODS.Joker {
    key = 'rock_candy',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 14
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "PsyAlola" }
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    end
}
