if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'hippie',
        atlas = 'Jokers',
        pos = {
            x = 8,
            y = 10
        },
        rarity = 2,
        config = {
            extra = {
                Xmult = 1,
                gain = 0.5
            }
        },
        mxms_credit = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        blueprint_compat = true,
        cost = 6,
        loc_vars = function(self, info_queue, card)
            local stg = card.ability.extra
            return {
                vars = { stg.Xmult, stg.gain }
            }
        end,
        calculate = function(self, card, context)
            local stg = card.ability.extra

            if context.mxms_beat_horoscope and not context.blueprint then
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "Xmult",
                    scalar_value = "gain",
                    message_key = 'a_mult',
                    message_colour = G.C.MULT
                })
                return nil, true
            end

            if context.joker_main and stg.Xmult > 1 then
                return {
                    x_mult = stg.Xmult
                }
            end
        end
    }

    SMODS.JimboQuip {
        key = 'wq_hippie',
        type = 'win',
        extra = { center = 'j_mxms_hippie' }
    }
else
    sendDebugMessage("Hippie not loaded; Horoscopes Disabled", 'Maximus')
end
