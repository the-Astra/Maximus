SMODS.Blind {
    key = 'hurdle',
    loc_txt = {
        name = 'The Hurdle',
        text = {
            'The first scoring card in',
            'played hand is debuffed'
        }
    },
    boss = {
        min = 1,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 6
    },
    boss_colour = HEX('EE6672'),
    calculate = function(self, card, context)
        if context.before and not G.GAME.blind.disabled then
            local first_card = context.scoring_hand[1]
            first_card.debuffed_by_blind = true
            first_card:set_debuff(true)
        end
    end,
    disable = function(self)
        for k, v in pairs(G.playing_cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end,
    defeat = function(self)
        for k, v in pairs(G.playing_cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end
}
