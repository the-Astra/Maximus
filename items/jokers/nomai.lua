if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'nomai',
        atlas = 'Jokers',
        pos = {
            x = 3,
            y = 14
        },
        rarity = 2,
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "theAstra" }
        },
        blueprint_compat = true,
        cost = 4,
        calculate = function(self, card, context)
            if context.using_consumeable and context.consumeable.ability.set == "Planet"
                and #G.mxms_horoscope.cards + G.GAME.mxms_horoscope_buffer < G.mxms_horoscope.config.card_limit then
                G.GAME.mxms_horoscope_buffer = G.GAME.mxms_horoscope_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local new_card = SMODS.add_card({
                            set = 'Horoscope',
                            area = G.mxms_horoscope,
                            key_append =
                            'nomai',
                            discover = true
                        })
                        new_card:juice_up(0.3, 0.4)
                        G.GAME.mxms_horoscope_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_mxms_plus_horoscope'),
                    colour = Maximus.C.HOROSCOPE
                }
            end
        end
    }
else
    sendDebugMessage("Nomai not loaded; Horoscopes Disabled", 'Maximus')
end
