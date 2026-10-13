SMODS.Joker {
    key = 'god_hand',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 13
    },
    rarity = 2,
    config = {
        extra = {
            id = nil,
            rank = nil,
            suit = nil,
            good_Xmult = 3,
            bad_Xmult = 0.5
        }
    },
    attributes = {
        'xmult',
        'suit',
        'rank'
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        if stg.rank then
            return {
                key = 'j_mxms_god_hand_target',
                vars = {
                    stg.good_Xmult,
                    stg.bad_Xmult,
                    stg.rank,
                    stg.suit,
                    colours = { G.C.SUITS[stg.suit] }
                }
            }
        else
            return {
                vars = {
                    stg.good_Xmult,
                    stg.bad_Xmult,
                }
            }
        end

        return {
            vars = { stg.good_Xmult, stg.bad_Xmult, rank, intermediary, suit, colours = { color } }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            local found_in_hand = false
            for k, v in pairs(G.hand.cards) do
                if v:is_suit(stg.suit) and v:get_id() == stg.id then
                    found_in_hand = true
                    break
                end
            end

            if found_in_hand then
                return {
                    x_mult = stg.good_Xmult
                }
            else
                return {
                    x_mult = stg.bad_Xmult
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local stg = card.ability.extra

        local chosen_card = pseudorandom_element(G.playing_cards, pseudoseed('god_hand' .. G.GAME.round_resets.ante))
        stg.id = chosen_card:get_id()
        stg.rank = SMODS.Ranks[chosen_card.base.value].key
        stg.suit = chosen_card.base.suit
    end
}
