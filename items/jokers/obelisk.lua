SMODS.Joker {
    key = 'obelisk',
    loc_txt = {
        name = 'Obelisk the Tormentor',
        text = { 
            'Gains {X:mult,C:white}X#1#{} Mult for every',
            '{C:attention}#3#{} played and unscored cards',
            '{s:0.8,C:inactive}Mult resets at end of round{}',
            '{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            gain = 1,
            Xmult = 1,
            unscoring_cards = 0,
            unscoring_goal = 2
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.Xmult, stg.unscoring_goal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.individual and context.cardarea == 'unscored' and not context.blueprint and not context.other_card.debuff then
            stg.unscoring_cards = stg.unscoring_cards + 1
            if stg.unscoring_cards < stg.unscoring_goal then
                return {
                    delay = 0.4,
                    message = stg.unscoring_cards .. '/' .. stg.unscoring_goal,
                    colour = G.C.MULT,
                    card = card
                }
            else
                stg.Xmult = stg.Xmult + stg.gain * G.GAME.soil_mod
                stg.unscoring_cards = 0
                SMODS.calculate_context({scaling_card = true})
                return {
                    delay = 0.4,
                    message = localize('Tribute!'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                Xmult_mod = stg.Xmult,
                message = 'X' .. stg.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            stg.unscoring_cards = 0
            stg.Xmult = 1
            return {
                message = localize('k_reset'),
                colour = G.C.RED,
                card = card
            }
        end
    end
}
