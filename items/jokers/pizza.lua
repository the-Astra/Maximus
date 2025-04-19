SMODS.Joker {
    key = 'pizza',
    loc_txt = {
        name = 'Pizza',
        text = {
            'Adds a {C:green}random{} seal to',
            'every {C:attention}scoring{} card',
            'Gets eaten after {C:attention}#1#{} cards'
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 13
    },
    rarity = 1,
    config = {
        extra = {
            cards_left = 8
        }
    },
    blueprint_compat = true,
    cost = 4,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.cards_left }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before then
            for k, v in ipairs(context.scoring_hand) do
                if not v.seal and not v.debuff and not v.pizza_sealed and stg.cards_left > 0 then
                    v.pizza_sealed = true
                    v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'pza' }))
                    stg.cards_left = stg.cards_left - 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            card:juice_up()
                            v.pizza_sealed = nil
                            return true
                        end
                    }))

                    if stg.cards_left <= 0 and not context.blueprint then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
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
                            card = card,
                            message = localize('k_eaten_ex'),
                            colour = G.C.FILTER
                        }
                    end
                end
            end
        end
    end
}
