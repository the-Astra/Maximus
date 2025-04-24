SMODS.Back {
    key = 'sixth_finger',
    atlas = 'Backs',
    pos = {
        x = 0,
        y = 0
    },
    apply = function(self, back)
        --Change highlight limit
        G.GAME.modifiers.mxms_highlight_limit = 6

        -- Make non-secret hands visible
        G.GAME.hands.mxms_three_pair.visible = true
        G.GAME.hands.mxms_double_triple.visible = true
        G.GAME.hands.mxms_s_straight.visible = true
        G.GAME.hands.mxms_s_flush.visible = true
        G.GAME.hands.mxms_house_party.visible = true
        G.GAME.hands.mxms_s_straight_f.visible = true
    end
}
