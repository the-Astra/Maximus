SMODS.Joker {
    key = 'clown_car',
    loc_txt = {
        name = 'Clown Car',
        text = { 
            'Gains {C:mult}+#2#{} Mult each time', 
            'a Joker is {C:attention}added{} to hand', 
            '{C:inactive}(Currently: {C:mult}+#1# {C:inactive}Mult)' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0,
            gain = 2
        }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.mult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.mult > 0 then
            return {
                mult_mod = stg.mult,
                message = '+' .. stg.mult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.card_added and context.card.ability.set == 'Joker' then
            stg.mult = stg.mult + (stg.gain * G.GAME.soil_mod)
            SMODS.calculate_context({scaling_card = true})
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.ATTENTION,
                card = card
            }
        end
    end
}
