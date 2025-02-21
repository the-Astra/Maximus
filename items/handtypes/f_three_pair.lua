SMODS.PokerHand {
    key = 'f_three_pair',
    mult = 14,
    chips = 150,
    l_mult = 3,
    l_chips = 30,
    example = {

        { 'S_K', true },
        { 'S_K', true },
        { 'S_9', true },
        { 'S_9', true },
        { 'S_6', true },
        { 'S_6', true }

    },
    loc_txt = {
        name = 'Flush Three Pair',
        description = {
            "3 Pairs of cards with different ranks with",
            "all cards sharing the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._2 == 3 and next(parts.mxms_s_flush) and
            { SMODS.merge_lists(parts._all_pairs, parts.mxms_s_flush) } or {}
    end
}
