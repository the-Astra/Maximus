SMODS.Joker {
    key = 'abyss',
    loc_txt = {
        name = "Abyss",
        text = { 'When blind is selected, {C:green}50/50{}', '{C:attention}chance{} of making a currently held',
            'non-negative Joker {C:dark_edition}Negative{} or', 'destroying a currently held non-negative joker',
            '{C:inactive}Can override other editions{}' }
    },
    atlas = 'Jokers',
    rarity = 3,
    pos = {
        x = 2,
        y = 0
    },
    blueprint_compat = true,
    cost = 9,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            -- Store all eligible jokers in table
            -- Code derived Madness
            local eligible_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and
                    not (G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative) and
                    not G.jokers.cards[i].getting_sliced then
                    eligible_jokers[#eligible_jokers + 1] = G.jokers.cards[i]
                end
            end

            -- Fail if no held jokers are eligible
            if next(eligible_jokers) == nil then
                return {
                    extra = {
                        message = 'No target...',
                        colour = G.C.PURPLE
                    },
                    card = card
                }
            else
                -- Choose Joker to affect
                local chosen_joker =
                    #eligible_jokers > 0 and
                    pseudorandom_element(eligible_jokers, pseudoseed('abyss' .. G.GAME.round_resets.ante)) or nil

                -- "Flip a coin" to decide what to do with the target
                local flip = pseudorandom(pseudoseed('aby' .. G.GAME.round_resets.ante), 1, 2)

                -- Add negative edition to random held joker
                if flip == 1 and chosen_joker ~= nil then
                    card:juice_up(0.3, 0.4)
                    chosen_joker:set_edition({
                        negative = true
                    }, true)
                    return {
                        extra = {
                            message = 'Void-touched!',
                            colour = G.C.PURPLE
                        },
                        card = card
                    }

                    -- Destroy a random non-negative joker
                elseif flip == 2 then
                    -- Double check the target is not self
                    -- Code derived Madness
                    if chosen_joker and not (context.blueprint_card or card).getting_sliced then
                        chosen_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                chosen_joker:start_dissolve({ G.C.PURPLE }, nil, 1.6)
                                return true;
                            end
                        }))
                    end
                    return {
                        extra = {
                            message = 'Consumed',
                            colour = G.C.PURPLE
                        },
                        card = card
                    }
                end
            end
        end
    end
}