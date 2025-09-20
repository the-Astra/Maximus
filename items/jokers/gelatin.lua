SMODS.Joker {
    key = 'gelatin',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 10
    },
    rarity = 2,
    config = {
        extra = {
            cards_left = 50,
            card_decrement = 1
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                stg.cards_left,
                localize(G.GAME.current_round.mxms_jello_suit, 'suits_singular'),
                colours = { G.C.SUITS[G.GAME.current_round.mxms_jello_suit] }
            }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.cardarea == G.play and context.repetition and stg.cards_left > 0 then
            if context.other_card:is_suit(G.GAME.current_round.mxms_jello_suit) then
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "cards_left",
                    scalar_value = "card_decrement",
                    operation = "-",
                    no_message = true
                })
                return {
                    repetitions = 1,
                    message = localize('k_again_ex'),
                    card = card
                }
            end
        end

        if context.after and not context.blueprint then
            if stg.cards_left <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex')
                }
            end
        end
    end
}
