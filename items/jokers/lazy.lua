SMODS.Joker {
    key = 'lazy',
    loc_txt = {
        name = 'Lazy Joker',
        text = { "{C:chips}+#1#{} Chips if played", "hand is", "a {C:attention}#2#" }
    },
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
                chip_mod = stg.chips,
                message = '+' .. stg.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}
