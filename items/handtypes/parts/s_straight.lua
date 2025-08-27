SMODS.PokerHandPart {
    key = 's_straight',
    func = function(hand)
        if G.STAGE == G.STAGES.RUN and G.hand.config.highlighted_limit >= 6 then
            return get_straight(hand, SMODS.four_fingers('straight') + 1, SMODS.shortcut(), SMODS.wrap_around_straight())
        end
    end
}
