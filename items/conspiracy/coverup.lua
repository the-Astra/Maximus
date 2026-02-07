SMODS.Consumable {
    key = 'coverup',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 2,
        y = 2
    },
    config = {
        extra = {
            odds = 5,
            cards = 3
        }
    },
    mxms_credits = {
        art = { "pangaea47" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    cost = 4,
    pixel_size = {w = 69, h = 73},
    display_size = {w = 69, h = 73},
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS['c_mxms_conspiracy_dummy']

        local consp_count = Maximus.count_conspiracy_cards()
        local prob, odds = SMODS.get_probability_vars(card, consp_count, stg.odds, 'coverup')

        return { vars = { prob, odds, stg.cards } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        local consp_count = Maximus.count_conspiracy_cards() + 1

        if SMODS.pseudorandom_probability(card, 'coverup', consp_count, stg.odds) then
            local chosen_card = G.hand.highlighted[1]

            local _rank = chosen_card.base.id
            if _rank < 10 then
                _rank = tostring(_rank)
            elseif _rank == 10 then
                _rank = 'T'
            elseif _rank == 11 then
                _rank = 'J'
            elseif _rank == 12 then
                _rank = 'Q'
            elseif _rank == 13 then
                _rank = 'K'
            elseif _rank == 14 then
                _rank = 'A'
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.8, 0.8)
                    chosen_card:start_dissolve()
                    for i = 1, stg.cards do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
                            func = function()
                                card:juice_up()
                                play_sound('tarot1')

                                local _suit = pseudorandom_element({ 'S', 'H', 'D', 'C' }, pseudoseed('coverup'))
                                local _card = create_playing_card({ front = G.P_CARDS[_suit .. '_' .. _rank] })
                                
                                G.hand:emplace(_card)
                                G.GAME.blind:debuff_card(_card)
                                G.hand:sort()

                                return true;
                            end
                        }))
                    end
                    return true;
                end
            }))
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
        return #G.hand.highlighted == 1 and G.hand.highlighted[1].ability.set == 'Enhanced'
    end
}
