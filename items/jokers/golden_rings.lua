SMODS.Joker {
    key = 'golden_rings',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 14
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    rarity = 1,
    blueprint_compat = false,
    cost = 5
}

local gf = get_flush

function get_flush(hand)
    if next(SMODS.find_card('j_mxms_golden_rings')) then
        local all_enhanced = true
        local rings_ret = {}
        local rings_table = {}
        for i = 1, #hand do
            if not next(SMODS.get_enhancements(hand[i])) then all_enhanced = false end
            rings_table[#rings_table + 1] = hand[i]
        end
        if all_enhanced and #hand >= (5 - (next(find_joker('Four Fingers')) and 1 or 0)) then
            table.insert(rings_ret, rings_table)
            return rings_ret
        end
    end

    return gf(hand)
end
