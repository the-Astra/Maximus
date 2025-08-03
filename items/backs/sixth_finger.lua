SMODS.Back {
    key = 'sixth_finger',
    atlas = 'Modifiers',
    pos = {
        x = 0,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    apply = function(self, back)
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
}
