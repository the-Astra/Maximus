SMODS.Joker {
    key = 'virus',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 3
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6
}

local gf = get_flush
function get_flush(hand)
    local ret = {}
    local suits = SMODS.Suit.obj_buffer
    if next(SMODS.find_card('j_mxms_virus')) then
        if #hand < 2 then
            -- Do nothing
        else
            for j = 1, #suits do
                local t = {}
                local suit = suits[j]
                local flush_count = 0
                for i = 1, #hand do
                    if hand[i]:is_suit(suit, nil, true) then
                        flush_count = flush_count + 1; t[#t + 1] = hand[i]
                    end
                end
                if flush_count == #hand and flush_count >= 2 then
                    table.insert(ret, t)
                    return ret
                end
            end
        end
    end
    return gf(hand)
end
