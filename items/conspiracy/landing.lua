SMODS.Consumable {
    key = 'landing',
    set = 'Conspiracy',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 2
    },
    config = {
        extra = {
            odds = 5,
            levels = 2
        }
    },
    mxms_credits = {
        art = { "???" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS['c_mxms_conspiracy_dummy']

        local consp_count = Maximus.count_conspiracy_cards()

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'landing'), stg.levels } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        local consp_count = Maximus.count_conspiracy_cards() + 1

        if SMODS.pseudorandom_probability(card, 'landing', consp_count, stg.odds) then
            local level, lowest = nil, {}

            for k, v in pairs(G.GAME.hands) do
                if v.visible and (not level or to_big(v.level) < level) then
                    level = to_big(v.level)
                    lowest = { k }
                elseif v.visible and to_big(v.level) == level then
                    lowest[#lowest + 1] = k
                end
            end

            local chosen_hand = pseudorandom_element(lowest, pseudoseed('landing'))

            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                {
                    handname = chosen_hand,
                    chips = G.GAME.hands[chosen_hand].chips,
                    mult = G.GAME.hands[chosen_hand].mult,
                    level = G.GAME.hands[chosen_hand].level
                })
            level_up_hand(card, chosen_hand, false, stg.levels)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                {
                    handname = '',
                    chips = 0,
                    mult = 0,
                    level = ''
                })
        else
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            attention_text({
                                text = localize('k_nope_ex'),
                                scale = 1.3,
                                hold = 1.4,
                                major = card,
                                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                    'tm' or 'cm',
                                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                                silent = true
                            })
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.06 * G.SETTINGS.GAMESPEED,
                                blockable = false,
                                blocking = false,
                                func = function()
                                    play_sound('tarot2', 0.76, 0.4); return true
                                end
                            }))
                            play_sound('tarot2', 1, 0.4)
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    return true;
                end
            }))
        end
    end,
    can_use = function(self, card)
        local stg = card.ability.extra

        return true
    end
}
