SMODS.Back {
    key = 'professional',
    loc_txt = {
        name = 'Professional Deck',
        text = {
            'Skipping blinds is {C:red}disabled',
            '{C:red}X1.25{} base Blind size'
        }
    },
    atlas = 'Backs',
    pos = {
        x = 3,
        y = 0
    },
    apply = function(self, back)
        --Disable skipping
        G.GAME.modifiers.disable_blind_skips = true

        -- Change blind size
        G.GAME.starting_params.ante_scaling = 1.25
    end
}

local cubt = create_UIBox_blind_tag
create_UIBox_blind_tag = function(blind_choice, run_info)
    if not G.GAME.modifiers.disable_blind_skips then
        return cubt(blind_choice, run_info)
    end
end

SMODS.Joker:take_ownership('j_throwback', {
    in_pool = function(self, args)
        return not G.GAME.modifiers.disable_blind_skips
    end
},
true)