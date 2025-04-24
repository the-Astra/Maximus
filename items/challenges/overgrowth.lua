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
    }
}

local gsr = G.start_run
function Game:start_run(args)
    gsr(self, args)
    if G.GAME.modifiers.mxms_X_blind_scale then
        G.GAME.modifiers.scaling = G.GAME.modifiers.mxms_X_blind_scale
    end
end
