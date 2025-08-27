SMODS.Back {
    key = 'professional',
    atlas = 'Modifiers',
    pos = {
        x = 3,
        y = 0
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    apply = function(self, back)
        --Disable skipping
        G.GAME.modifiers.disable_blind_skips = true

        -- Change blind size
        G.GAME.starting_params.ante_scaling = 1.25

        -- Ban some Jokers that rely on skipping
        G.GAME.banned_keys[#G.GAME.banned_keys + 1] = 'j_throwback'
        G.GAME.banned_keys[#G.GAME.banned_keys + 1] = 'j_mxms_hopscotch'
    end
}
