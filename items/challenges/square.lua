SMODS.Challenge {
    key = 'square',
    rules = {
        custom = {
            { id = 'mxms_highlight_limit', value = 4 }
        }
    },
    jokers = {},
    restrictions = {
        banned_other = {
            { id = 'bl_psychic', type = 'blind' }
        }
    },
    deck = {
        type = 'Challenge Deck'
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_play_limit(G.GAME.modifiers.mxms_highlight_limit - 5)
                SMODS.change_discard_limit(G.GAME.modifiers.mxms_highlight_limit - 5)
                return true;
            end
        }))
    end
}
