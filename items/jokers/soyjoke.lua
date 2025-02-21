SMODS.Joker {
    key = 'soyjoke',
    loc_txt = {
        name = 'Soyjoke',
        text = { '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X0.25{} Mult', 'every time a Joker', 'is re-added to hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.soy_mod }
        }
    end,
    calculate = function(self, card, context)
        card.ability.extra.Xmult = G.GAME.soy_mod

        if context.joker_main and G.GAME.soy_mod > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}