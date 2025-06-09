SMODS.PokerHand {
    key = 's_straight',
    mult = 6,
    chips = 50,
    l_mult = 3,
    l_chips = 50,
    atlas = 'poker_hands',
    pos = { x = 0, y = 3 },
    example = {

        { 'S_A', true },
        { 'D_K', true },
        { 'C_Q', true },
        { 'H_J', true },
        { 'S_T', true },
        { 'D_9', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_s_straight) and parts.mxms_s_straight or {}
    end
}
