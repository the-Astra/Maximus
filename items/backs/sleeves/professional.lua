CardSleeves.Sleeve {
    key = "professional",
    atlas = "Sleeves",
    pos = {
        x = 4,
        y = 0
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_professional' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key, vars = { colours = { G.C.HAND_LEVELS[2] } } }
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == 'b_mxms_professional' then
            -- If on Professional Deck, +1 level for each hand type
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in pairs(G.GAME.hands) do
                        level_up_hand(self, k, true)
                    end
                    return true;
                end
            }))
        else
            -- Disable skipping
            G.GAME.modifiers.disable_blind_skips = true

            -- Change blind size
            G.GAME.starting_params.ante_scaling = 1.25

            -- Ban some Jokers that rely on skipping
            G.GAME.banned_keys[#G.GAME.banned_keys + 1] = 'j_throwback'
            G.GAME.banned_keys[#G.GAME.banned_keys + 1] = 'j_mxms_hopscotch'
        end
    end
}
