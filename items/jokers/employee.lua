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
                for k,v in pairs(G.mxms_horoscope.cards) do
                    card:juice_up(0.3, 0.4)
                    SMODS.calculate_effect({ dollars = stg.dollars }, v)
                end
            end
        end,
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    }
else
    sendDebugMessage("Employee not loaded; Horoscopes Disabled", 'Maximus')
end