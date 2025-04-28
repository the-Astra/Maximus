SMODS.Joker {
    key = 'comedian',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 12
    },
    rarity = 1,
    config = {
        extra = {
            Xmult = 1,
            gain = 1,
            odds = 50
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.Xmult, stg.gain, G.GAME.probabilities.normal, stg.odds * G.GAME.fridge_mod } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if pseudorandom('comedian') < G.GAME.probabilities.normal / stg.odds * G.GAME.fridge_mod then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
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
                                SMODS.calculate_context({ failed_prob = true, odds = stg.odds -
                                G.GAME.probabilities.normal })
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_extinct_ex')
                }
            else
                stg.Xmult = stg.Xmult + stg.gain
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_xmult', vars = { stg.Xmult } }, colour = G.C
                        .MULT }, card)
                        return true
                    end
                }))
                SMODS.calculate_context({ scaling_card = true })
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        return G.GAME.pool_flags.cavendish_removed
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}

SMODS.Joker:take_ownership('j_cavendish', {
        remove_from_deck = function(self, args)
            G.GAME.pool_flags.cavendish_removed = true
        end
    },
    true)
