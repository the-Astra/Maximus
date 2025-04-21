SMODS.Joker {
    key = 'rock_candy',
    loc_txt = {
        name = 'Rock Candy',
        text = { 
            '{C:attention}Stone{} Cards can',
            'be used as any suit'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
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
}
