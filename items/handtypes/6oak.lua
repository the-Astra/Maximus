SMODS.PokerHand {
    key = '6oak',
    mult = 18,
    chips = 180,
    l_mult = 4,
    l_chips = 40,
    atlas = 'poker_hands',
    pos = { x = 0, y = 2 },
    example = {

        { 'S_K', true },
        { 'D_K', true },
        { 'C_K', true },
        { 'H_K', true },
        { 'S_K', true },
        { 'D_K', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_6) and parts.mxms_6 or {}
    end
}
