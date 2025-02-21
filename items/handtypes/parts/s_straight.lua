SMODS.PokerHandPart {
    key = 's_straight',
    func = function(hand)
        if G.STAGE == G.STAGES.RUN and G.hand.config.highlighted_limit >= 6 then
            local ret = {}
            local four_fingers = next(find_joker('Four Fingers'))
            if #hand > 6 or #hand < (6 - (four_fingers and 1 or 0)) then
                return ret
            else
                local t = {}
                local IDS = {}
                for i = 1, #hand do
                    local id = hand[i]:get_id()
                    if id > 1 and id < 15 then
                        if IDS[id] then
                            IDS[id][#IDS[id] + 1] = hand[i]
                        else
                            IDS[id] = { hand[i] }
                        end
                    end
                end

                local straight_length = 0
                local straight = false
                local can_skip = next(find_joker('Shortcut'))
                local skipped_rank = false
                for j = 1, 14 do
                    if IDS[j == 1 and 14 or j] then
                        straight_length = straight_length + 1
                        skipped_rank = false
                        for k, v in ipairs(IDS[j == 1 and 14 or j]) do
                            t[#t + 1] = v
                        end
                    elseif can_skip and not skipped_rank and j ~= 14 then
                        skipped_rank = true
                    else
                        straight_length = 0
                        skipped_rank = false
                        if not straight then t = {} end
                        if straight then break end
                    end
                    if straight_length >= (6 - (four_fingers and 1 or 0)) then straight = true end
                end
                if not straight then return ret end
                table.insert(ret, t)
                return ret
            end
        end
    end
}
