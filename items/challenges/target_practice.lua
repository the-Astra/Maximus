SMODS.Challenge {
    key = 'target_practice',
    loc_txt = {
        name = 'Target Practice'
    },
    rules = {
        custom = {
            { id = 'mxms_bullseye_requirement', value = 500 }
        }
    },
    jokers = {
        { id = 'j_mr_bones',      edition = 'negative' },
        { id = 'j_mxms_bullseye', edition = 'negative', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    }
}
