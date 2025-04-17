SMODS.Joker {
    key = 'dont_mind_if_i_do',
    loc_txt = {
        name = 'Don\'t Mind if I Do',
        text = { 
            'Gains {X:mult,C:white}X#2#{} Mult for every', 
            'card scored {C:attention}with a seal{} at the',
            'cost of {C:red}removing{} the seal', 
            '{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 5
    },
    blueprint_compat = false,
    cost = 7,
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.25
        }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].seal then
                    local other_card = context.scoring_hand[i]
                    other_card:set_seal(nil, nil, true)
                    stg.Xmult = stg.Xmult + stg.gain
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.50,
                        func = function()
                            play_sound('card1')
                            card:juice_up(0.3, 0.3)
                            other_card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                    SMODS.calculate_context({scaling_card = true})
                end
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                Xmult_mod = stg.Xmult,
                message = 'X' .. stg.Xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if v.seal then
                return true
            end
        end

        return false
    end
}
