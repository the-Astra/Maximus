if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'letter',
        atlas = 'Jokers',
        pos = {
            x = 1,
            y = 11
        },
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        rarity = 2,
        blueprint_compat = true,
        cost = 4,
        calculate = function(self, card, context)
            if context.mxms_beat_horoscope and #G.mxms_horoscope.cards + G.GAME.mxms_horoscope_buffer < G.mxms_horoscope.config.card_limit + 1 then
                G.GAME.mxms_horoscope_buffer = G.GAME.mxms_horoscope_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            set = 'Horoscope',
                            area = G.mxms_horoscope,
                            key_append = 'lor',
                            discover = true
                        })
                        G.GAME.mxms_horoscope_buffer = G.GAME.mxms_horoscope_buffer - 1
                        return true;
                    end
                }))
                SMODS.calculate_effect({ message = localize('k_mxms_plus_horoscope'), colour = Maximus.C.HOROSCOPE },
                    context.blueprint_card or card)
            end
        end
    }
else
    sendDebugMessage("Letter of Recommendation not loaded; Horoscopes Disabled", 'Maximus')
end
