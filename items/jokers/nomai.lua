SMODS.Joker {
    key = 'nomai',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and context.consumeable.ability.set == "Planet"
            and #G.mxms_horoscope.cards + G.GAME.horoscope_buffer < G.mxms_horoscope.config.card_limit then
            G.GAME.horoscope_buffer = G.GAME.horoscope_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    local new_card = create_card('Horoscope', G.mxms_horoscope, nil, nil, nil, nil, nil, 'nomai')
                    new_card:add_to_deck()
                    G.mxms_horoscope:emplace(new_card)
                    new_card:juice_up(0.3, 0.4)
                    G.GAME.horoscope_buffer = 0
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
