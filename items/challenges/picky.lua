SMODS.Challenge {
    key = 'picky',
    rules = {
        custom = {
            { id = 'mxms_picky' },
            { id = 'mxms_picky2' },
        }
    },
    jokers = {},
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local new_card = SMODS.add_card({
                        set = 'Joker',
                        key = 'j_mxms_four_course_meal',
                        key_append = 'picky'
                    })
                    new_card:juice_up(0.3, 0.4)
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    return true;
                end
            }))
        end
    end
}
