SMODS.Joker {
    key = 'fortune_cookie',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    perishable_compat = false,
    eternal_compat = false,
    blueprint_compat = true,
    cost = 4,
    pools = {
        Food = true
    },
    config = {
        extra = {
            prob = 10,
            odds = 10
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { SMODS.get_probability_vars(card, stg.prob, stg.odds, 'fco'), G.GAME.probabilities.normal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        -- Activate ability before scoring if chance is higher than 0
        if context.before and stg.prob > 0 then
            -- Roll chance and decrease by 1
            local chance_roll = SMODS.pseudorandom_probability(card, 'fco', stg.prob, stg.odds)
            stg.prob = stg.prob - (1 / G.GAME.mxms_fridge_mod)

            -- Check if Consumables is full
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                -- Successful roll
                if (chance_roll) then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            (context.blueprint_card or card):juice_up(0.3, 0.4)

                            SMODS.add_card({
                                set = 'Tarot',
                                key_append = 'fco'
                            })
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true;
                        end
                    }))
                    return {
                        sound = 'tarot1',
                        message = localize('k_mxms_fortunate_ex'),
                        colour = G.C.SECONDARY_SET.Tarot
                    }

                    -- Failed Roll
                else
                    return {
                        sound = 'tarot2',
                        message = localize('k_nope_ex'),
                        colour = G.C.SET.Tarot
                    }
                end
            else
                return {
                    sound = 'tarot2',
                    message = localize('k_mxms_wasted'),
                    colour = G.C.SET.Tarot
                }
            end

            return {
                card = card,
                message = '-1',
                colour = G.C.RED
            }
        end

        -- "Crumble" card after scoring
        if context.after and not context.blueprint then
            if stg.prob <= 0 then
                -- Code derived from Gros Michel/Cavendish
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_mxms_crumbled'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}
