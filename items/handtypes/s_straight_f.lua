SMODS.PokerHand {
    key = 's_straight_f',
    mult = 20,
    chips = 200,
    l_mult = 5,
    l_chips = 55,
    example = {

        { 'S_A', true },
        { 'S_K', true },
        { 'S_Q', true },
        { 'S_J', true },
        { 'S_T', true },
        { 'S_9', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_s_straight) and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts.mxms_s_straight, parts.mxms_s_flush) } or {}
    end
}
