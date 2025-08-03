CardSleeves.Sleeve {
    key = "sixth_finger",
    atlas = "Sleeves",
    pos = {
        x = 0,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_sixth_finger' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == 'b_mxms_sixth_finger' then
            -- If on Sixth Finger Deck, enable double exoplanet modifier
            G.GAME.modifiers.mxms_double_exoplanet = true
        else
            --Change limits
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.change_play_limit(1)
                    SMODS.change_discard_limit(1)
                    return true;
                end
            }))

            if Maximus_config.new_handtypes then
                -- Make non-secret hands visible
                G.GAME.hands.mxms_three_pair.visible = true
                G.GAME.hands.mxms_double_triple.visible = true
                G.GAME.hands.mxms_s_straight.visible = true
                G.GAME.hands.mxms_s_flush.visible = true
                G.GAME.hands.mxms_house_party.visible = true
                G.GAME.hands.mxms_s_straight_f.visible = true
            end
        end
    end,
    calculate = function(self, sleeve, context)
        if G.GAME.modifiers.mxms_double_exoplanet and context.using_consumeable and context.consumeable.ability.consumeable.mxms_exoplanet then
            SMODS.smart_level_up_hand(sleeve, context.consumeable.ability.consumeable.hand_type)
        end
    end,
}
