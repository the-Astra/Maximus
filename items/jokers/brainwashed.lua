SMODS.Joker {
    key = 'brainwashed',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 13
    },
    rarity = 2,
    config = {
        extra = {
            prob = 1,
            odds = 2
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { SMODS.get_probability_vars(card, stg.prob, stg.odds, 'bwash') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.after and SMODS.pseudorandom_probability(card, 'bwash', stg.prob, stg.odds) and next(context.poker_hands['Flush']) then
            local valid_cards = {}
            local flush_suit = G.play.cards[1].base.suit

            for k, v in pairs(G.hand.cards) do
                if not v:is_suit(flush_suit, true) then
                    valid_cards[#valid_cards + 1] = v
                end
            end

            if next(valid_cards) then
                local chosen_card = pseudorandom_element(valid_cards, pseudoseed('bwash_card'))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        (context.blueprint_card or card):juice_up(0.3, 0.4)
                        play_sound('tarot1')
                        delay(0.3)
                        chosen_card:flip()
                        play_sound('card1', 1.15)
                        return true;
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        SMODS.change_base(chosen_card, flush_suit, nil)
                        return true;
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        chosen_card:flip()
                        play_sound('card1', 0.85)
                        return true;
                    end
                }))
            end
        end
    end
}
