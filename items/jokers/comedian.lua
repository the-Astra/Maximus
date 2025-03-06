SMODS.Joker {
    key = 'comedian',
    loc_txt = {
        name = 'Comedian',
        text = { '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X#2#{} Mult', 'after every round', '{C:green}#3# in #4# chance this', 'card is destroyed at', 'end of round' }
    },
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
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
        return { vars = { stg.Xmult, stg.gain, G.GAME.probabilities.normal, stg.odds } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if pseudorandom('comedian') < G.GAME.probabilities.normal / stg.odds then
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
                                mxms_scale_pessimistics(G.GAME.probabilities.normal, stg.odds)
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
                stg.Xmult = card:scale_value(stg.Xmult, stg.gain)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.calculate_effect({message = localize { type = 'variable', key = 'a_xmult', vars = { stg.Xmult } }, colour = G.C.MULT}, card)
                        return true
                    end
                }))
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                Xmult_mod = stg.Xmult,
                message = 'x' .. stg.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self, args)
        return G.GAME.pool_flags.cavendish_removed
    end
}
