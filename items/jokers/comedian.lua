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
            prob = 1,
            odds = 50
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 4,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.Xmult, stg.gain, SMODS.get_probability_vars(card, stg.prob, stg.odds, 'comedian') } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if SMODS.pseudorandom_probability(card, 'comedian', stg.prob, stg.odds) then
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
                stg.Xmult = stg.Xmult + stg.gain * G.GAME.mxms_soil_mod
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.calculate_effect(
                            {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { stg.Xmult } },
                                colour = G.C
                                    .MULT
                            }, card)
                        return true
                    end
                }))
                SMODS.calculate_context({ mxms_scaling_card = true })
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        return G.GAME.pool_flags.mxms_cavendish_removed
    end
}

SMODS.Joker:take_ownership('j_cavendish', {
        remove_from_deck = function(self, args)
            G.GAME.pool_flags.mxms_cavendish_removed = true
        end
    },
    true)
