SMODS.Consumable {
    key = 'pyramid',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = {
            odds = 5
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
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone

        local consp_count = Maximus.count_conspiracy_cards()

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'pyramid') } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        local consp_count = Maximus.count_conspiracy_cards() + 1

        if SMODS.pseudorandom_probability(card, 'pyramid', consp_count, stg.odds) then
            for k, v in pairs(G.hand.cards) do
                if v:is_suit("Spades") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            local front = pseudorandom_element(G.P_CARDS, pseudoseed('slide_fr'))
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local new_card = Card(G.play.T.x + G.play.T.w / 2, G.play.T.y, G.CARD_W, G.CARD_H, front,
                                G.P_CENTERS.m_stone, { playing_card = G.playing_card })
                            new_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                            G.deck:emplace(new_card)
                            table.insert(G.playing_cards, new_card)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced },
                    card)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
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
        return #G.hand.cards > 0
    end
}
