SMODS.Joker {
    key = 'dont_mind_if_i_do',
    loc_txt = {
        name = 'Don\'t Mind if I Do',
        text = { 'Gains {X:mult,C:white}X0.25{} Mult for every', 'card scored with a seal at the cost of',
            'removing the seal', '{C:inactive}Currently: {X:mult,C:white}X#1#' }
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
            Xmult = 1
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.Xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].seal then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.50,
                        func = function()
                            local other_card = context.scoring_hand[i]
                            play_sound('card1')
                            card:juice_up(0.3, 0.3)
                            other_card:juice_up(0.3, 0.3)
                            other_card:set_seal(nil, nil, true)
                            card.ability.extra.Xmult = card:scale_value(card.ability.extra.Xmult, 0.25)
                            return true
                        end
                    }))
                end
            end
        end

        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
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