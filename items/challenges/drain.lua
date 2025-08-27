SMODS.Challenge {
    key = 'drain',
    rules = {
        custom = {
            { id = 'mxms_hand_decay', value = "Flush" }
        }
    },
    jokers = {
        { id = 'j_smeared',    eternal = true },
        { id = 'j_mxms_faded', eternal = true }
    },
    vouchers = {
        { id = 'v_telescope' }
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.ante_end then
            SMODS.smart_level_up_hand(nil, G.GAME.modifiers.mxms_hand_decay, nil, -5)
        end
    end
}
