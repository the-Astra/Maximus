SMODS.Joker {
    key = 'ledger',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 7
    },
    soul_pos = {
        x = 0,
        y = 8
    },
    cost = 20,
    rarity = 4,
    config = {},
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
            local eligible_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].edition and not G.jokers.cards[i].getting_sliced then
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
                -- Choose Joker to affect
                local chosen_joker =
                    #eligible_jokers > 0 and
                    pseudorandom_element(eligible_jokers, pseudoseed('ledger' .. G.GAME.round_resets.ante)) or nil

                -- Add negative edition to random held joker

                if chosen_joker ~= nil then
                    chosen_joker:set_edition({
                        negative = true
                    }, true)
                    return {
                        extra = {
                            message = localize('k_mxms_serious_q'),
                            colour = G.C.PURPLE
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
