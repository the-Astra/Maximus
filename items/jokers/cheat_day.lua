if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'cheat_day',
        atlas = 'Jokers',
        pos = {
            x = 0,
            y = 11
        },
        rarity = 2,
        blueprint_compat = false,
        cost = 4,
        calculate = function(self, card, context)
            local stg = card.ability.extra

            if context.failed_horoscope then
                SMODS.calculate_effect({ message = localize('k_saved_ex'), colour = G.C.HOROSCOPE, sound = 'tarot1' },
                    card)
            end
        end,
        set_badges = function(self, card, badges)
            if self.discovered then
                badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
            end
        end
    }
else
    sendDebugMessage("Cheat Day not loaded; Horoscopes Disabled", 'Maximus')
end
