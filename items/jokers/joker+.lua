SMODS.Joker {
    key = 'joker_plus',
    loc_txt = {
        name = 'Joker+',
        text = { '{C:mult}+5{} Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 1
    },
    rarity = 3,
    config = {
        extra = {
            mult = 5
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            return {
                mult_mod = stg.mult,
                message = '+' .. stg.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
