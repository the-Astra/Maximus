SMODS.Joker {
    key = 'template',
    loc_txt = {
        name = 'Template',
        text = { 
            'I\'m a template!'
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
        }
    },
    blueprint_compat = true,
    cost = 4,
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
