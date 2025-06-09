SMODS.PokerHandPart {
    key = 's_straight',
    func = function(hand)
        if G.STAGE == G.STAGES.RUN and G.hand.config.highlighted_limit >= 6 then
            return get_straight(hand, next(SMODS.find_card('j_four_fingers')) and 5 or 6, not not next(SMODS.find_card('j_shortcut')))
        end
    end
}
