SMODS.Joker {
    key = 'astigmatism',
    loc_txt = {
        name = 'Astigmatism',
        text = { '{X:chips,C:white}x#1#{} Chips' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            Xchips = 2
        }
    },
    blueprint_compat = true,
    cost = 9,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xchips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            return {
                Xchip_mod = stg.Xchips,
                message = 'x'..stg.Xchips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}