SMODS.Joker {
    key = 'letter',
    loc_txt = {
        name = 'Letter of Recommendation',
        text = { 'Creates a random {C:horoscope}Horoscope{}', 'card after one {C:attention}succeeds{}' }
    },
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
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
            SMODS.calculate_effect({ message = '+ Horoscope', colour = G.C.HOROSCOPE },
                context.blueprint_card or card)
        end
    end
}
