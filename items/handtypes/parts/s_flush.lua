SMODS.PokerHandPart {
    key = 's_flush',
    func = function(hand)
        if G.STAGE == G.STAGES.RUN and G.hand.config.highlighted_limit >= 6 then

            if next(SMODS.find_card('j_mxms_golden_rings')) then
                local all_enhanced = true
                local rings_ret = {}
                local rings_table = {}
                for i = 1, #hand do
                    if not next(SMODS.get_enhancements(hand[i])) then all_enhanced = false end
                    rings_table[#rings_table + 1] = hand[i]
                end
                if all_enhanced and #hand >= (6 - (next(find_joker('Four Fingers')) and 1 or 0)) then
                    table.insert(rings_ret, rings_table)
                    return rings_ret
                end
            end

            local ret = {}
            local four_fingers = next(find_joker('Four Fingers'))
            local suits = SMODS.Suit.obj_buffer
            if #hand < (6 - (four_fingers and 1 or 0)) then
                return ret
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
                    if flush_count >= (6 - (four_fingers and 1 or 0)) then
                        table.insert(ret, t)
                        return ret
                    end
                end
                return {}
            end
        end
    end
}
