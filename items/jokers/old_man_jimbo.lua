SMODS.Joker {
    key = 'old_man_jimbo',
    loc_txt = {
        name = 'Old Man Jimbo',
        text = { '{X:mult,C:white}X1{} Mult plus {X:mult,C:white}X0.5{}', 'for each remaining hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 0
        }
    },
    blueprint_compat = true,
    cost = 6,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.Xmult = 1 + (0.5 * G.GAME.current_round.hands_left)
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}