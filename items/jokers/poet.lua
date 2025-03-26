SMODS.Joker {
    key = 'poet',
    loc_txt = {
        name = 'Poet',
        text = { 'If hand type is played {C:attention}exclusively{} with number ranks', 'matching the {C:attention}hand name{}, give {X:mult,C:white}Xmult{} equal to that rank', '{s:0.8,C:inactive}Two Pair must be played with a pair of 2s and', '{s:0.8,C:inactive}a pair of faces or aces' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 5
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
                        message = 'X2',
                        Xmult_mod = 2,
                        colour = G.C.MULT,
                        card = card
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
                        message = 'X3',
                        Xmult_mod = 3,
                        colour = G.C.MULT,
                        card = card
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
                        message = 'X3',
                        Xmult_mod = 3,
                        colour = G.C.MULT,
                        card = card
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
                        message = 'X4',
                        Xmult_mod = 4,
                        colour = G.C.MULT,
                        card = card
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
                        message = 'X5',
                        Xmult_mod = 5,
                        colour = G.C.MULT,
                        card = card
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
                        message = 'X6',
                        Xmult_mod = 6,
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end
        end
    end
}
