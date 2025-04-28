SMODS.Joker {
    key = 'jobber',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 0
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
                        extra = {
                            message = localize('k_mxms_no_target_el'),
                            colour = G.C.PURPLE
                        },
                        card = card
                    }
                else
                    -- Destroy Jobber
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve({ G.C.YELLOW }, nil, 1.6)
                            return true;
                        end
                    }))
                end

                -- Choose Joker to copy
                local chosen_joker = #eligible_jokers > 0 and
                    pseudorandom_element(eligible_jokers, pseudoseed('jobber' .. G.GAME.round_resets.ante)) or nil

                -- Copy Joker and add to hand
                if chosen_joker ~= nil then
                    local new_card = copy_card(chosen_joker, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                    new_card:start_materialize()
                    new_card:add_to_deck()
                    if new_card.edition and new_card.edition.negative then
                        new_card:set_edition(nil, true)
                    end
                    G.jokers:emplace(new_card)
                    return {
                        extra = {
                            message = localize('k_mxms_jobbed'),
                            colour = G.C.YELLOW
                        },
                        card = card
                    }
                end
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
