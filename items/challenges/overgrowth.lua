SMODS.Challenge {
    key = 'overgrowth',
    rules = {
        custom = {
            { id = 'mxms_X_blind_scale', value = 8 }
        }
    },
    jokers = {
        { id = 'j_mxms_soil', edition = 'negative', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.modifiers.scaling = G.GAME.modifiers.mxms_X_blind_scale
                return true;
            end
        }))
    end
}
