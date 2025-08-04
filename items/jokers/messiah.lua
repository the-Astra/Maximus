SMODS.Joker {
    key = 'messiah',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 13
    },
    rarity = 1,
    config = {
        extra = {
            mult = 0,
            gain = 5
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" },
        reference = { "OneShot" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS['c_sun']
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and context.consumeable.config.center.key == 'c_sun' and not context.blueprint then
            stg.mult = stg.mult + stg.gain * G.GAME.mxms_soil_mod
            SMODS.calculate_effect(
                { message = localize { type = 'variable', key = 'a_mult', vars = { stg.mult } }, colour = G.C.MULT },
                card)
            SMODS.calculate_context({ mxms_scaling_card = true })
        end

        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult
            }
        end
    end
}
