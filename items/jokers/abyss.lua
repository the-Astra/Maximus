SMODS.Joker {
    key = 'abyss',
    atlas = 'Jokers',
    rarity = 3,
    pos = {
        x = 2,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 9,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            -- Store all eligible jokers in table
            -- Code derived Madness
            local eligible_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i]) and
                    not (G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative) and
                    not G.jokers.cards[i].getting_sliced then
                    eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                end
            end

            -- Fail if no held jokers are eligible
            if not next(eligible_jokers) then
                return {
                    message = localize('k_mxms_no_target_el'),
                    colour = G.C.PURPLE
                }
            else
                -- Choose Joker to affect
                local chosen_joker = pseudorandom_element(eligible_jokers,
                    pseudoseed('abyss' .. G.GAME.round_resets.ante))

                -- "Flip a coin" to decide what to do with the target
                local flip = pseudorandom(pseudoseed('aby' .. G.GAME.round_resets.ante), 1, 2)

                if flip == 1 then -- Add negative edition to random held joker
                    (context.blueprint_card or card):juice_up(0.3, 0.4)
                    chosen_joker:set_edition({ negative = true }, true)
                    return {
                        message = localize('k_mxms_void_touched_ex'),
                        colour = G.C.PURPLE
                    }
                elseif flip == 2 then -- Destroy a random non-negative joker
                    -- Double check the target is not self
                    -- Code derived Madness
                    if chosen_joker and not (context.blueprint_card or card).getting_sliced then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                chosen_joker:start_dissolve({ G.C.PURPLE }, nil, 1.6)
                                return true;
                            end
                        }))
                    end
                    return {
                        message = localize('k_mxms_consumed'),
                        colour = G.C.PURPLE
                    }
                end
            end
        end
    end
}
