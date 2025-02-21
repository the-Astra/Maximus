SMODS.Joker {
    key = 'clown_car',
    loc_txt = {
        name = 'Clown Car',
        text = { 'Gains {C:mult}+2{} Mult each time', 'a Joker is added to hand', '{C:inactive}Currently: +#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}