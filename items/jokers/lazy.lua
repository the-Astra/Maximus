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
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.chips, center.ability.type }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                chip_mod = card.ability.chips,
                message = '+' .. card.ability.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}