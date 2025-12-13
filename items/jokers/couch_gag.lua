SMODS.Joker {
    key = 'couch_gag',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 18
    },
    rarity = 2,
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 end
            juice_card_until(card, eval, true)
        end

        if context.repetition and context.cardarea == G.play and next(context.poker_hands['Full House']) and G.GAME.current_round.hands_played == 0 then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}
