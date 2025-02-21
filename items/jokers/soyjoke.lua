SMODS.Joker {
    key = 'soyjoke',
    loc_txt = {
        name = 'Soyjoke',
        text = { '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X#2#{} Mult', 'every time a Joker', 'is re-added to hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            gain = 0.25
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { G.GAME.soy_mod * stg.gain + 1, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and G.GAME.soy_mod >= 1 then
            return {
                Xmult_mod = G.GAME.soy_mod * stg.gain + 1,
                message = 'X' .. G.GAME.soy_mod * stg.gain + 1,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}