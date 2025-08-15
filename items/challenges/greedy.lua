SMODS.Challenge {
    key = 'greedy',
    rules = {
        custom = {
            { id = 'mxms_greedy' },
            { id = 'mxms_greedy2' },
        },
        modifiers = {
            { id = 'dollars', value = 10 }
        }
    },
    jokers = {
        { id = 'j_delayed_grat' },
        { id = 'j_mxms_trick_or_treat', eternal = true },
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.skipping_booster then
            Maximus.force_game_over()
        end

        if context.ending_shop and #G.shop_booster.cards > 0 then
            Maximus.force_game_over()
        end
    end
}
