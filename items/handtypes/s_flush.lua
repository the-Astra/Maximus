SMODS.PokerHand {
    key = 's_flush',
    mult = 6,
    chips = 55,
    l_mult = 2,
    l_chips = 25,
    example = {

        { 'S_A', true },
        { 'S_K', true },
        { 'S_J', true },
        { 'S_8', true },
        { 'S_6', true },
        { 'S_2', true }

    },
    loc_txt = {
        name = 'Super Flush',
        description = {
            "6 cards that share the same suit"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.mxms_s_flush) and parts.mxms_s_flush or {}
    end
}
