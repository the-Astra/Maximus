SMODS.Joker {
    key = 'old_man_jimbo',
    loc_txt = {
        name = 'Old Man Jimbo',
        text = { 
            '{X:mult,C:white}X1{} Mult plus {X:mult,C:white}X#1#{}', 
            'for each remaining hand' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            gain = 0.5
        }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.gain } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            return {
                Xmult_mod = 1 + (stg.gain* G.GAME.current_round.hands_left),
                message = 'X' .. 1 + (stg.gain* G.GAME.current_round.hands_left),
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
