SMODS.Back {
    key = 'nuclear',
    loc_txt = {
        name = 'Nuclear Deck',
        text = {
            '{C:attention}-4{} Joker slots',
            '{C:mult}Mult{} is now an {C:attention}exponent{} of {C:chips}Chips{}',
            'Blind Sizes are multiplied', 'to the {C:red}ante-th power{}',
            '{C:inactive}This deck will not count towards best hand scores',
            '{s:0.8,C:inactive}Works best with Talisman installed'
        }
    },
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
