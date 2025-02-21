SMODS.Challenge {
    key = 'picky',
    loc_txt = {
        name = 'Picky Eater'
    },
    rules = {
        custom = {
            { id = 'mxms_picky' }
        }
    },
    jokers = {},
    deck = {
        type = 'Challenge Deck'
    }
}

local bsb = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
    bsb(self, blind, reset, silent)
    if blind and blind.name and G.GAME.modifiers.mxms_picky and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
        local new_card = SMODS.add_card({
            set = 'Joker',
            key = 'j_mxms_four_course_meal',
            key_append = 'picky'
        })
        new_card:juice_up(0.3, 0.4)
        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
    end
end