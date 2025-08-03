SMODS.Joker {
    key = 'fog',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 9
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 5,
    rarity = 2
}

-- Change 4oaK and 2P to work with Fog
SMODS.PokerHand:take_ownership('Four of a Kind', {
        evaluate = function(parts, hand)
            if #parts._2 == 2 and next(SMODS.find_card('j_mxms_fog')) then
                local pair_1 = parts._2[1]
                local pair_2 = parts._2[2]
                if math.abs(pair_1[1]:get_id() - pair_2[2]:get_id()) == 1 or (pair_1[1]:get_id() == 14 and pair_2[1]:get_id() == 2) then
                    return parts._all_pairs
                end
            end
            return parts._4
        end
    },
    true)

SMODS.PokerHand:take_ownership('Two Pair', {
        evaluate = function(parts, hand)
            if next(parts._4) and next(SMODS.find_card('j_mxms_fog')) then return parts._4 end
            if #parts._2 < 2 then return {} end
            return parts._all_pairs
        end
    },
    true)
