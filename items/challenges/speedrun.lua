SMODS.Challenge {
    key = 'speedrun',
    rules = {
        custom = {
            { id = 'mxms_speedrun' },
            { id = 'mxms_disable_blind_skips' },
            { id = 'mxms_win_ante',           value = 4 },
        }
    },
    jokers = {
        { id = 'j_mxms_4d' },
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.four_d_death then
            Maximus.force_game_over()
        end
    end,
    apply = function(self)
        G.GAME.modifiers.disable_blind_skips = true
        G.GAME.win_ante = 4
        Maximus_config.four_d_ticks = true
    end
}
