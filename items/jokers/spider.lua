SMODS.Joker {
    key = 'spider',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 17
    },
    rarity = 1,
    config = {
        extra = {
            prob = 1,
            odds = 8,
            mult = 5
        }
    },
    credit = {
        art = "anerdymous",
        code = "theAstra",
        concept = "anerdymous"
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            if pseudorandom('spider') < (stg.prob * G.GAME.probabilities.normal) / stg.odds then
                local og_sound = G.SETTINGS.SOUND.music_volume
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.SETTINGS.SOUND.music_volume <= 0 then
                            G.SETTINGS.SOUND.music_volume = 0
                            return true
                        else
                            G.SETTINGS.SOUND.music_volume = G.SETTINGS.SOUND.music_volume - 0.5
                            return false
                        end
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        check_for_unlock({ type = 'spider_trigger' })
                        return true;
                    end
                }))
                return {
                    mult = stg.mult,
                    delay = 4,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 2,
                            func = function()
                                if G.SETTINGS.SOUND.music_volume >= og_sound then
                                    G.SETTINGS.SOUND.music_volume = og_sound
                                    G:save_settings()
                                    return true
                                else
                                    G.SETTINGS.SOUND.music_volume = G.SETTINGS.SOUND.music_volume + 1
                                    return false
                                end
                            end
                        }))
                    end
                }
            else
                SMODS.calculate_context({
                    mxms_failed_prob = true,
                    odds = stg.odds - (stg.prob * G.GAME.probabilities.normal),
                    card = card
                })
            end
        end
    end
}
