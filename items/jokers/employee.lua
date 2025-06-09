if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'employee',
        atlas = 'Jokers',
        pos = {
            x = 2,
            y = 11
        },
        rarity = 2,
        config = {
            extra = {
                dollars = 5
            }
        },
        credit = {
            art = "Maxiss02",
            code = "theAstra",
            concept = "Maxiss02"
        },
        blueprint_compat = true,
        cost = 7,
        loc_vars = function(self, info_queue, card)
            local stg = card.ability.extra
            return {
                vars = { stg.dollars }
            }
        end,
        calculate = function(self, card, context)
            local stg = card.ability.extra

            if context.end_of_round and not context.individual and not context.repetition then
                for k, v in pairs(G.mxms_horoscope.cards) do
                    card:juice_up(0.3, 0.4)
                    SMODS.calculate_effect({ dollars = stg.dollars }, v)
                end
            end
        end
    }
else
    sendDebugMessage("Employee not loaded; Horoscopes Disabled", 'Maximus')
end
