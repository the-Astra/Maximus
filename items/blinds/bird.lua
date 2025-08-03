SMODS.Blind {
    key = 'bird',
    boss = {
        min = 4,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 8
    },
    config = {
        extra = {
            hands_removed = 0
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    boss_colour = HEX('BFFF3A'),
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        self.triggered = true
        return math.max(mult - (G.GAME.hands[text].l_mult * 2), G.GAME.hands[text].s_mult),
            math.max(hand_chips - (G.GAME.hands[text].l_chips * 2), G.GAME.hands[text].s_chips),
            true
    end
}
