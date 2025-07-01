SMODS.Consumable {
    key = 'mission',
    set = 'Tarot',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 2
    },
    config = {
        max_highlighted = 2,
        mod_conv = 'm_mxms_footprint'
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['mxms_footprint']
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "N/A"
    }
}
