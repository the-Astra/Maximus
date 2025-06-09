SMODS.PokerHand {
    key = 'f_double_triple',
    mult = 16,
    chips = 170,
    l_mult = 4,
    l_chips = 50,
    atlas = 'poker_hands',
    pos = { x = 0, y = 7 },
    example = {

        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_9', true },
        { 'S_9', true },
        { 'S_9', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._3 >= 2 and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts._all_pairs, parts.mxms_s_flush) } or {}
    end
}
