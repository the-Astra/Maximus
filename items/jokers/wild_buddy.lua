SMODS.Joker {
    key = 'wild_buddy',
    loc_txt = {
        name = 'Wild Buddy',
        text = { 
            '{X:mult,C:white}X#1#{} Mult during',
            '{C:attention}non-Boss{} Blinds'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            Xmult = 2
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        
        if context.joker_main and not G.GAME.blind.boss then
            return {
                Xmult_mod = stg.Xmult,
                message = 'X'..stg.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
