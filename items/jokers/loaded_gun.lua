SMODS.Joker {
    key = 'loaded_gun',
    loc_txt = {
        name = 'Loaded Gun',
        text = { 
            'Scoring {C:attention}Steel Cards{}', 
            'give {X:mult,C:white}X#1#{} Mult' 
        }
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
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { stg.Xmult } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_steel') then
            return {
                x_mult = stg.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
