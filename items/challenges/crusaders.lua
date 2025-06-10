SMODS.Challenge {
    key = 'crusaders',
    rules = {},
    jokers = {},
    vouchers = {
        { id = 'v_tarot_merchant' }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_magic_trick' },
            { id = 'v_illusion' },
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
            { id = 'j_dna' },
            { id = 'j_certificate' },
            { id = 'j_marble' },
            { id = 'j_mxms_rock_slide' },
            { id = 'j_mxms_leto' },
            { id = 'c_cryptid' },
            { id = 'c_grim' },
            { id = 'c_familiar' },
            { id = 'c_incantation' },
        }
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = "D", r = "K" },
            { s = "D", r = "K" },
            { s = "D", r = "K" },
            { s = "D", r = "K" },
            { s = "D", r = "K" }
        }
    }
}