SMODS.Joker {
    key = 'prince',
    loc_txt = {
        name = 'The Prince',
        text = { 
            'I\'m a template!'
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 12
    },
    rarity = 3,
    config = {
        extra = {
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        
    end
}
