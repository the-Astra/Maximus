SMODS.Joker {
    key = 'poet',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 5
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            local same_rank = true
            if context.scoring_name == 'Two Pair' then
                local two_count = 0
                local face_count = 0
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() == 2 then
                        two_count = two_count + 1
                    elseif v:get_id() > 10 then
                        face_count = face_count + 1
                    end
                end

                if two_count == 2 and face_count == 2 then
                    return {
                        x_mult = 2
                    }
                end
            end

            if context.scoring_name == 'Three Pair' then
                local three_count = 0
                local face_count = 0
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() == 2 then
                        three_count = three_count + 1
                    elseif v:get_id() > 10 then
                        face_count = face_count + 1
                    end
                end

                if three_count == 2 and face_count == 4 then
                    return {
                        x_mult = 3,
                    }
                end
            end

            if context.scoring_name == 'Three of a Kind' then
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() ~= 3 then
                        same_rank = false
                    end
                end

                if same_rank then
                    return {
                        x_mult = 3
                    }
                end
            end

            if context.scoring_name == 'Four of a Kind' then
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() ~= 4 then
                        same_rank = false
                    end
                end

                if same_rank then
                    return {
                        x_mult = 4
                    }
                end
            end

            if context.scoring_name == 'Five of a Kind' or context.scoring_name == 'Flush Five' then
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() ~= 5 then
                        same_rank = false
                    end
                end

                if same_rank then
                    return {
                        x_mult = 5,
                    }
                end
            end

            if context.scoring_name == 'Six of a Kind' or context.scoring_name == 'Flush Six' then
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() ~= 5 then
                        same_rank = false
                    end
                end

                if same_rank then
                    return {
                        x_mult = 6,
                    }
                end
            end
        end
    end
}
