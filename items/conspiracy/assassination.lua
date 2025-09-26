SMODS.Consumable {
    key = 'assassination',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            seal = 'Red',
            odds = 5
        }
    },
    mxms_credits = {
        art = { "SadCube" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    cost = 4,
    pixel_size = {w = 69, h = 73},
    display_size = {w = 69, h = 73},
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS['c_mxms_conspiracy_dummy']
        info_queue[#info_queue + 1] = G.P_SEALS['Red']

        local consp_count = Maximus.count_conspiracy_cards()

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'assassination') } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        local consp_count = Maximus.count_conspiracy_cards() + 1

        if SMODS.pseudorandom_probability(card, 'assassination', consp_count, stg.odds) then
            local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('assassination'))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    chosen_joker:start_dissolve()
                    card:juice_up(0.8, 0.8)
                    return true;
                end
            }))
            local i = 1
            for k, v in pairs(G.hand.cards) do
                if not v.seal then
                    local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                    i = i + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            v:set_seal(stg.seal, true, true)
                            play_sound('card1', percent)
                            return true;
                        end
                    }))
                end
            end
            delay(0.5)
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
        return G.jokers and #G.jokers.cards > 0 and #G.hand.cards > 0
    end
}
