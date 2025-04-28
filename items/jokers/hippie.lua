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

            if context.beat_horoscope and not context.blueprint then
                stg.Xmult = stg.Xmult + stg.gain
                SMODS.calculate_effect(
                    { message = localize { type = 'variable', key = 'a_xmult', vars = { stg.Xmult } } },
                    card)
                SMODS.calculate_context({ scaling_card = true })
            end

            if context.joker_main and stg.Xmult > 1 then
                return {
                    x_mult = stg.Xmult
                }
            end
        end,
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    }
else
    sendDebugMessage("Hippie not loaded; Horoscopes Disabled", 'Maximus')
end
