SMODS.Consumable {
    key = 'tinfoil',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 0,
        y = 2
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

        local consp_count = Maximus.count_conspiracy_cards()

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'tinfoil') } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        local consp_count = Maximus.count_conspiracy_cards() + 1

        if SMODS.pseudorandom_probability(card, 'tinfoil', consp_count, stg.odds) then
            G.GAME.blind:disable()
            play_sound('timpani')
            SMODS.calculate_effect({ message = localize('ph_boss_disabled')},card)
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
        
        return G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled
    end
}
