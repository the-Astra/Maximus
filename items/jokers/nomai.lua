if Maximus_config.horoscopes then
    SMODS.Joker {
        key = 'nomai',
        atlas = 'Jokers',
        pos = {
            x = 3,
            y = 14
        },
        rarity = 2,
        config = {
            extra = {
            }
        },
        credit = {
            art = "Maxiss02",
            code = "theAstra",
            concept = "theAstra"
        },
        blueprint_compat = true,
        cost = 4,
        calculate = function(self, card, context)
            local stg = card.ability.extra

            if context.using_consumeable and context.consumeable.ability.set == "Planet"
                and #G.mxms_horoscope.cards + G.GAME.mxms_horoscope_buffer < G.mxms_horoscope.config.card_limit then
                G.GAME.mxms_horoscope_buffer = G.GAME.mxms_horoscope_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local new_card = create_card('Horoscope', G.mxms_horoscope, nil, nil, nil, nil, nil, 'nomai')
                        new_card:add_to_deck()
                        G.mxms_horoscope:emplace(new_card)
                        new_card:juice_up(0.3, 0.4)
                        G.GAME.mxms_horoscope_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_mxms_plus_horoscope'),
                    colour = G.C.horoscope
                }
            end
        end
    }
else
    sendDebugMessage("Nomai not loaded; Horoscopes Disabled", 'Maximus')
end
