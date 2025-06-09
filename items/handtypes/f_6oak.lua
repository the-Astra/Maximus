SMODS.PokerHand {
    key = 'f_6oak',
    mult = 22,
    chips = 220,
    l_mult = 5,
    l_chips = 50,
    atlas = 'poker_hands',
    pos = { x = 0, y = 10 },
    example = {

        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true },
        { 'S_K', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_6) and next(parts.mxms_s_flush)
            and { SMODS.merge_lists(parts.mxms_6, parts.mxms_s_flush) } or {}
    end
}
