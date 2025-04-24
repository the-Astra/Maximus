SMODS.Joker {
    key = 'streaker',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            streak = 0,
            hands = 0, -- I know there's an tracker in vanilla but I can't access it at context.end_of_round
            chips = 0,
            mult = 0,
            chip_gain = 20,
            mult_gain = 5
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.streak, stg.hands, stg.chips, stg.mult, stg.chip_gain * G.GAME.soil_mod, stg.mult_gain * G.GAME.soil_mod }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.streak > 0 then
            return {
                mult_mod = stg.mult,
                chip_mod = stg.chips,
                message = localize('k_mxms_streaked_ex'),
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before and not context.blueprint then
            stg.hands = stg.hands + 1
            if stg.hands > 1 and stg.streak ~= 0 then
                stg.streak = 0
                stg.chips = 0
                stg.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if stg.hands == 1 then
                stg.hands = 0
                stg.streak = stg.streak + 1
                stg.chips = stg.chip_gain * stg.streak * G.GAME.soil_mod
                stg.mult = stg.mult_gain * stg.streak * G.GAME.soil_mod
                return {
                    message = 'Streak ' .. stg.streak,
                    colour = G.C.CHIPS,
                    card = card,
                    func = function() SMODS.calculate_context({scaling_card = true}) end
                }
            else
                stg.hands = 0
            end
        end
    end
}
