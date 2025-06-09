SMODS.PokerHand {
    key = 'f_party',
    mult = 16,
    chips = 180,
    l_mult = 4,
    l_chips = 50,
    atlas = 'poker_hands',
    pos = { x = 0, y = 9 },
    example = {

        { 'S_A', true },
        { 'S_A', true },
        { 'S_A', true },
        { 'S_A', true },
        { 'S_T', true },
        { 'S_T', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        if #parts._4 < 1 or #parts._2 < 2 then return {} end
        return #hand >= 6 and next(parts._2) and next(parts._4) and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts._all_pairs, parts.mxms_s_flush) } or {}
    end
}
