SMODS.Consumable {
    key = 'aeon',
    set = 'Tarot',
    atlas = 'Consumables',
    pos = {
        x = 0,
        y = 4
    },
    config = {
        max_highlighted = 2,
        mod_conv = 'm_mxms_footprint'
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_mxms_footprint']
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
    mxms_credits = {
        art = { "SadCube" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    }
}
