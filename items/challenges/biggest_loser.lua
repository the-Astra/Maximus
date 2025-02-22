SMODS.Challenge {
    key = 'biggest_loser',
    loc_txt = {
        name = 'Tonight\'s Biggest Loser'
    },
    rules = {
        custom = {
            { id = 'mxms_biggest_loser' }
        }
    },
    jokers = {
        { id = 'j_mxms_stop_sign',         edition = 'negative', eternal = true },
        { id = 'j_mxms_impractical_joker', edition = 'negative', eternal = true, posted = true }
    },
    deck = {
        type = 'Challenge Deck'
    }
}
