if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'letter',
        atlas = 'Jokers',
        pos = {
            x = 1,
            y = 11
        },
        rarity = 2,
        blueprint_compat = true,
        cost = 4,
        calculate = function(self, card, context)
            local stg = card.ability.extra

            if context.beat_horoscope and #G.mxms_horoscope.cards + G.GAME.horoscope_buffer < G.mxms_horoscope.config.card_limit + 1 then
                G.GAME.horoscope_buffer = G.GAME.horoscope_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            set = 'Horoscope',
                            key_append = 'lor'
                        })
                        G.GAME.horoscope_buffer = G.GAME.horoscope_buffer - 1
                        return true;
                    end
                }))
                SMODS.calculate_effect({ message = localize('k_mxms_plus_horoscope'), colour = G.C.HOROSCOPE },
                    context.blueprint_card or card)
            end
        end,
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    }
else
    sendDebugMessage("Letter of Recommendation not loaded; Horoscopes Disabled", 'Maximus')
end
