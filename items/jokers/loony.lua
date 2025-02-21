SMODS.Joker {
    key = 'loony',
    loc_txt = {
        name = 'Loony Joker',
        text = { "{C:mult}+#1#{} Mult if played", "hand is", "a {C:attention}#2#" }
    },
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
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.mult, center.ability.type }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                mult_mod = card.ability.mult,
                message = '+' .. card.ability.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}