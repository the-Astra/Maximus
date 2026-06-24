SMODS.Challenge {     -- Zodiac Killer
    key = 'killer',
    rules = {
        custom = {
            { id = 'mxms_zodiac_killer' },
            { id = 'mxms_zodiac_killer2' },
        }
    },
    jokers = {},
    restrictions = {
        banned_cards = {
            { id = 'p_mxms_horoscope_normal_1', ids = {
                'p_mxms_horoscope_normal_1', 'p_mxms_horoscope_normal_2',
                'p_mxms_horoscope_jumbo_1', 'p_mxms_horoscope_mega_1' }
            },
            { id = 'j_mxms_cheat_day' },
            { id = 'j_mxms_letter' },
            { id = 'j_mxms_nomai' },
            { id = 'c_mxms_ophiucus' },
        },
        banned_tags = {
            { id = 'tag_mxms_star' },
        }
    },
    deck = {
        type = 'Challenge Deck'
    },
    apply = function(self)
        if not Maximus_config.horoscopes then
            Maximus_config.horoscopes = true
            G.FUNCS.mxms_toggle_horoscopes(true)
        end

        G.GAME.mxms_zodiac_killer_pools = {}

        G.E_MANAGER:add_event(Event({
            func = function()
                local new_card = SMODS.add_card({
                    set = 'Horoscope',
                    key_append = 'killer'
                })
                new_card:juice_up(0.3, 0.4)
                return true;
            end
        }))
    end,
    calculate = function(self, context)
        if context.mxms_beat_horoscope then
            G.GAME.mxms_zodiac_killer_pools[context.card.config.center_key] = true
        end

        if context.mxms_failed_horoscope or context.selling_card and context.card.ability.set == 'Horoscope' then
            Maximus.force_game_over()
        end

        if context.ante_end then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    local new_card = SMODS.add_card({
                        set = 'Horoscope',
                        key_append = 'killer'
                    })
                    new_card:juice_up(0.3, 0.4)
                    return true
                end
            }))
        end
    end
}
