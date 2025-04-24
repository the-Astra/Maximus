SMODS.Back {
    key = 'nuclear',
    atlas = 'Backs',
    pos = {
        x = 2,
        y = 0
    },
    apply = function(self, back)
        --Change blind scaling
        G.GAME.modifiers.mxms_nuclear_size = true

        --Change joker slots
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - 4
    end
}
