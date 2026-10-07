SMODS.Challenge {
    key = 'gambling',
    rules = {
        custom = {
            { id = 'no_extra_hand_money' },
            { id = 'no_reward' },
            { id = 'no_interest' },
            { id = 'mxms_gambling' },
        },
        modifiers = {
            { id = 'dollars', value = 10 }
        }
    },
    jokers = {},
    restrictions = {
        banned_tags = {
            { id = 'tag_uncommon' },
            { id = 'tag_rare' },
            { id = 'tag_negative' },
            { id = 'tag_foil' },
            { id = 'tag_holo' },
            { id = 'tag_polychrome' },
            { id = 'tag_voucher' },
            { id = 'tag_boss' },
            { id = 'tag_standard' },
            { id = 'tag_charm' },
            { id = 'tag_meteor' },
            { id = 'tag_buffoon' },
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_ethereal' },
            { id = 'tag_coupon' },
            { id = 'tag_double' },
            { id = 'tag_juggle' },
            { id = 'tag_d_six' },
            { id = 'tag_top_up' },
            { id = 'tag_orbital' },
            { id = 'tag_mxms_star' },
        }
    },
    deck = {
        type = 'Challenge Deck'
    }
}
