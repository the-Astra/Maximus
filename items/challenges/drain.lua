SMODS.Challenge {
    key = 'drain',
    loc_txt = {
        name = 'Down the Drain'
    },
    rules = {
        custom = {
            { id = 'mxms_hand_decay', value = "Flush" }
        }
    },
    jokers = {
        { id = 'j_smeared',    eternal = true },
        { id = 'j_mxms_faded', eternal = true }
    },
    vouchers = {
        { id = 'v_telescope' }
    },
    deck = {
        type = 'Challenge Deck'
    }
}
