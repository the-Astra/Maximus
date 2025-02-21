SMODS.PokerHand {
    key = 'double_triple',
    mult = 6,
    chips = 60,
    l_mult = 2,
    l_chips = 35,
    example = {

        { 'S_K', true },
        { 'D_K', true },
        { 'C_K', true },
        { 'S_9', true },
        { 'D_9', true },
        { 'C_9', true }

    },
    loc_txt = {
        name = 'Double Triple',
        description = {
            "Two 3 of a Kinds"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return #parts._3 >= 2 and parts._all_pairs or {}
    end
}
