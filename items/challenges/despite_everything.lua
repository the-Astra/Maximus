SMODS.Challenge {
    key = 'despite',
    rules = {
        custom = {
            { id = 'mxms_ante_sell' }
        }
    },
    jokers = {
        { id = 'j_joker', edition = 'negative', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.ante_end then
            for k, v in pairs(G.jokers.cards) do
                if not (v.ability and v.ability.eternal) then
                    v:sell_card()
                end
            end

            for k, v in pairs(G.consumeables.cards) do
                if not (v.ability and v.ability.eternal) then
                    v:sell_card()
                end
            end
        end
    end
}
