SMODS.Joker {
    key = 'romero',
    loc_txt = {
        name = 'Romero',
        text = { 
            'Gains {X:mult,C:white}X#2#{} Mult', 
            'every time a Joker', 
            'is added to hand',
            '{C:inactive}(Currently: {X:mult,C:white}X#1# {C:inactive}Mult)'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 4,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.1
        }
    },
    blueprint_compat = true,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult , stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and stg.Xmult >= 1 then
            return {
                Xmult_mod = stg.Xmult,
                message = 'X' .. stg.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end

        if context.card_added and context.card.ability.set == 'Joker' then
            stg.Xmult = stg.Xmult + (stg.gain * G.GAME.soil_mod)
            SMODS.calculate_context({scaling_card = true})
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.ATTENTION,
                card = card
            }
        end
    end
}
