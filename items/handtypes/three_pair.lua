SMODS.PokerHand {
    key = 'three_pair',
    mult = 4,
    chips = 30,
    l_mult = 1,
    l_chips = 25,
    example = {

        { 'S_K', true },
        { 'D_K', true },
        { 'S_9', true },
        { 'D_9', true },
        { 'S_6', true },
        { 'D_6', true }

    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._2 >= 3 and parts._all_pairs or {}
    end
}
