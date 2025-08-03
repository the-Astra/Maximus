if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'cheat_day',
        atlas = 'Jokers',
        pos = {
            x = 0,
            y = 11
        },
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        rarity = 2,
        blueprint_compat = false,
        cost = 4,
        calculate = function(self, card, context)
            if context.mxms_failed_horoscope and not context.blueprint then
                SMODS.calculate_effect(
                { message = localize('k_saved_ex'), colour = Maximus.C.HOROSCOPE, sound = 'tarot1' }, card)
            end
        end
    }
else
    sendDebugMessage("Cheat Day not loaded; Horoscopes Disabled", 'Maximus')
end
