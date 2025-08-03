SMODS.Joker {
    key = 'perspective',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 0
    },
    rarity = 1,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 3
}

-- Change Full House to not interfere with Perspective
SMODS.PokerHand:take_ownership('Full House', {
        evaluate = function(parts, hand)
            if #parts._3 < 1 or #parts._2 < 2 or #hand < 5 then return {} end
            return parts._all_pairs
        end
    },
    true)
