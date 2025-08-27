SMODS.Challenge {
    key = 'love_and_war',
    rules = {
        custom = {
            { id = 'mxms_deck_size_req', value = 1 }
        }
    },
    jokers = {
        { id = 'j_mxms_war', edition = 'negative', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.end_of_round and G.GAME.round_resets.ante == G.GAME.win_ante and G.GAME.blind:get_type() == 'Boss' then
            if #G.GAME.playing_cards ~= G.GAME.modifiers.mxms_deck_size_req then
                Maximus.force_game_over()
            end
        end
    end
}
