SMODS.Joker {
    key = 'loaded_gun',
    loc_txt = {
        name = 'Loaded Gun',
        text = { 'Played {C:attention}Steel Cards{}', 'give {X:mult,C:white}X2{} Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 4
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 2
        }
    },
    blueprint_compat = true,
    cost = 8,
    enhancement_gate = 'm_steel',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.config.center == G.P_CENTERS.m_steel then
            return {
                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}