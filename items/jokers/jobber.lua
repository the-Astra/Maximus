SMODS.Joker {
    key = 'jobber',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            -- Check if played hand is all debuffed cards
            local all_debuffed = true
            for i = 1, #context.scoring_hand do
                if not context.scoring_hand[i].debuff then
                    all_debuffed = false
                    break
                end
            end

            -- Fail if not all debuffed
            if not all_debuffed then
                return
            else
                -- Store all eligible jokers in table
                -- Code derived Madness
                local eligible_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card then
                        eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                    end
                end

                -- Fail if no held jokers are eligible
                if next(eligible_jokers) == nil then
                    return {
                        message = localize('k_mxms_no_target_el'),
                        colour = G.C.RED
                    }
                else
                    -- Destroy Jobber
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve({ G.C.YELLOW }, nil, 1.6)
                            return true;
                        end
                    }))

                    -- Choose Joker to copy
                    local chosen_joker = #eligible_jokers > 0 and
                        pseudorandom_element(eligible_jokers, pseudoseed('jobber' .. G.GAME.round_resets.ante)) or nil

                    -- Copy Joker and add to hand
                    if chosen_joker then
                        local new_card = copy_card(chosen_joker, nil, nil, nil,
                            chosen_joker.edition and chosen_joker.edition.negative)
                        new_card:start_materialize()
                        new_card:add_to_deck()
                        if new_card.edition and new_card.edition.negative then
                            new_card:set_edition(nil, true)
                        end
                        G.jokers:emplace(new_card)
                        return {
                            message = localize('k_mxms_jobbed'),
                            colour = G.C.YELLOW
                        }
                    end
                end
            end
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_jobber',
    type = 'loss',
    extra = { center = 'j_mxms_jobber' }
}