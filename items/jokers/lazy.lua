SMODS.Joker {
    key = 'lazy',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 4
    },
    rarity = 1,
    config = {
        chips = 40,
        type = 'High Card'
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability
        return {
            vars = { stg.chips, stg.type }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                chips = stg.chips
            }
        end
    end
}
