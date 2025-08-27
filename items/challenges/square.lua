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
        SMODS.change_play_limit(self.GAME.modifiers.mxms_highlight_limit - 5)
        SMODS.change_discard_limit(self.GAME.modifiers.mxms_highlight_limit - 5)
    end
}
