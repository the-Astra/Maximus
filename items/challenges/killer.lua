SMODS.Challenge { -- Zodiac Killer
    key = 'killer',
    loc_txt = {
        name = 'Zodiac Killer'
    },
    rules = {
        custom = {
            { id = 'mxms_zodiac_killer' }
        }
    },
    jokers = {},
    restrictions = {
        banned_cards = {
            { id = 'p_mxms_horoscope_normal_1', ids = {
                'p_mxms_horoscope_normal_1', 'p_mxms_horoscope_normal_2',
                'p_mxms_horoscope_jumbo_1', 'p_mxms_horoscope_mega_1' }
            },
        },
        banned_tags = {
            { id = 'tag_mxms_star' },
        }
    },
    deck = {
        type = 'Challenge Deck'
    }
}

local gsr = G.start_run
function Game:start_run(args)
    gsr(self, args)
    if G.GAME.modifiers.mxms_zodiac_killer then
        local new_card = SMODS.add_card({
            set = 'Horoscope',
            key_append = 'killer'
        })
        new_card:juice_up(0.3, 0.4)
    end
end