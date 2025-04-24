SMODS.Joker {
    key = 'loony',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 4
    },
    rarity = 1,
    config = {
        mult = 10,
        type = 'High Card'
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability
        return {
            vars = { stg.mult, stg.type }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                mult = stg.mult
            }
        end
    end
}
