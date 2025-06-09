SMODS.PokerHand {
    key = 'double_triple',
    mult = 6,
    chips = 60,
    l_mult = 2,
    l_chips = 35,
    atlas = 'poker_hands',
    pos = { x = 0, y = 1 },
    example = {

        { 'S_K', true },
        { 'D_K', true },
        { 'C_K', true },
        { 'S_9', true },
        { 'D_9', true },
        { 'C_9', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._3 >= 2 and parts._all_pairs or {}
    end
}
