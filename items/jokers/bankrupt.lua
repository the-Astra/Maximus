SMODS.Joker {
    key = 'bankrupt',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 16
    },
    rarity = 1,
    config = {
        extra = {
            gain = 10,
            mult = 0
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "anerdymous"
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.mxms_failed_prob and context.card.config.center.key == 'c_wheel_of_fortune' then
            stg.mult = stg.mult + stg.gain * G.GAME.soil_mod
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { stg.mult } },
                func = function() SMODS.calculate_context({ mxms_scaling_card = true }) end
            }
        end

        if context.joker_main then
            return {
                mult = stg.mult
            }
        end
    end
}
