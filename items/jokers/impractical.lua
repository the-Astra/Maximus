SMODS.Joker {
    key = 'impractical_joker',
    loc_txt = {
        name = 'Impractical Joker',
        text = { 'If a {C:attention}#2#{} is played,', '{X:mult,C:white}X3{} Mult. If three hands in a',
            'row are not this hand type, {X:mult,C:white}X0.5{} Mult', '{C:inactive}Hand rotates every round',
            '{C:inactive}Fail streak: #1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 3,
            fails = 0
        }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.fails, G.GAME.current_round.impractical_hand }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            -- If correct hand is played
            if context.scoring_name == G.GAME.current_round.impractical_hand then
                if not context.blueprint then
                    card.ability.extra.fails = 0
                    card.ability.extra.Xmult = 3
                end

                return {
                    message = 'X' .. card.ability.extra.Xmult,
                    Xmult_mod = card.ability.extra.Xmult,
                    colour = G.C.MULT,
                    card = card
                }

                -- If incorrect hand is played
            else
                if not context.blueprint then
                    card.ability.extra.fails = card.ability.extra.fails + 1
                end

                -- If below 3 fails
                if card.ability.extra.fails < 3 then
                    return {
                        message = 'Fail ' .. card.ability.extra.fails,
                        colour = G.C.RED,
                        card = card
                    }

                    -- If 3 fails
                elseif card.ability.extra.fails == 3 then
                    card.ability.extra.Xmult = 0.5
                    return {
                        message = 'Tonight\'s Biggest Loser',
                        Xmult_mod = card.ability.extra.Xmult,
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.fails = 0
            return {
                message = localize('k_reset'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}