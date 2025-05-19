SMODS.Joker {
    key = 'romero',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 7
    },
    soul_pos = {
        x = 3,
        y = 8
    },
    rarity = 4,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.1
        }
    },
    unlocked = false,
    unlock_condition = {
        type = '', 
        extra = '', 
        hidden = true
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "PsyAlola"
    },
    blueprint_compat = true,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and stg.Xmult >= 1 then
            return {
                x_mult = stg.Xmult
            }
        end

        if context.card_added and context.card.ability.set == 'Joker' then
            stg.Xmult = stg.Xmult + (stg.gain * G.GAME.soil_mod)
            SMODS.calculate_context({ scaling_card = true })
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.ATTENTION,
                card = card,
                func = function() SMODS.calculate_context({ scaling_card = true }) end
            }
        end
    end
}
