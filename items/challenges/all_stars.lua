SMODS.Challenge {
    key = 'all_stars',
    rules = {
        custom = {
            { id = 'mxms_all_rare' }
        }
    },
    jokers = {},
    restrictions = {
        banned_cards = {
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
            { id = 'p_arcana_normal_1', ids = {
                'p_arcana_normal_1', 'p_arcana_normal_2',
                'p_arcana_normal_3', 'p_arcana_normal_4',
                'p_arcana_jumbo_1', 'p_arcana_jumbo_2',
                'p_arcana_mega_1', 'p_arcana_mega_2' }
            },
            { id = 'p_celestial_normal_1', ids = {
                'p_celestial_normal_1', 'p_celestial_normal_2',
                'p_celestial_normal_3', 'p_celestial_normal_4',
                'p_celestial_jumbo_1', 'p_celestial_jumbo_2',
                'p_celestial_mega_1', 'p_celestial_mega_2' }
            },
            { id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1', 'p_buffoon_normal_2',
                'p_buffoon_jumbo_1', 'p_buffoon_mega_1' }
            },
            { id = 'p_mxms_horoscope_normal_1', ids = {
                'p_mxms_horoscope_normal_1', 'p_mxms_horoscope_normal_2',
                'p_mxms_horoscope_jumbo_1', 'p_mxms_horoscope_mega_1' }
            },
        }
    },
    deck = {
        type = 'Challenge Deck'
    }
}
