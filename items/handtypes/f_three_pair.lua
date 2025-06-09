SMODS.PokerHand {
    key = 'f_three_pair',
    mult = 14,
    chips = 150,
    l_mult = 3,
    l_chips = 30,
    atlas = 'poker_hands',
    pos = { x = 0, y = 6 },
    example = {

        { 'S_K', true },
        { 'S_K', true },
        { 'S_9', true },
        { 'S_9', true },
        { 'S_6', true },
        { 'S_6', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._2 == 3 and next(parts.mxms_s_flush) and
            { SMODS.merge_lists(parts._all_pairs, parts.mxms_s_flush) } or {}
    end
}
