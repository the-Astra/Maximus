SMODS.PokerHand {
    key = 'house_party',
    mult = 8,
    chips = 70,
    l_mult = 3,
    l_chips = 40,
    atlas = 'poker_hands',
    pos = { x = 0, y = 5 },
    example = {

        { 'S_A', true },
        { 'D_A', true },
        { 'C_A', true },
        { 'H_A', true },
        { 'S_T', true },
        { 'D_T', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        if #parts._4 < 1 or #parts._2 < 2 then return {} end
        return #hand >= 6 and next(parts._2) and next(parts._4) and
            { SMODS.merge_lists(parts._all_pairs) } or {}
    end
}
