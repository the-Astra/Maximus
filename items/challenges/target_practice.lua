SMODS.Challenge {
    key = 'target_practice',
    rules = {
        custom = {
            { id = 'mxms_bullseye_requirement', value = 500 },
            { id = 'mxms_bullseye_requirement2'},
        }
    },
    jokers = {
        { id = 'j_mr_bones',      edition = 'negative' },
        { id = 'j_mxms_bullseye', edition = 'negative', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.end_of_round and G.GAME.round_resets.ante == G.GAME.win_ante and G.GAME.blind:get_type() == 'Boss' then
            if next(SMODS.find_card('j_mxms_bullseye'))
            and G.GAME.modifiers.mxms_bullseye_requirement > SMODS.find_card('j_mxms_bullseye')[1].ability.extra.chips
            or not next(SMODS.find_card('j_mxms_bullseye')) then
                Maximus.force_game_over()
            end
        end
    end
}
