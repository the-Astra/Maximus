SMODS.Blind {
    key = 'rot',
    boss = {
        min = 1,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    boss_colour = HEX('A2CA4C'),
    set_blind = function(self)
        for i = 1, #G.playing_cards / 4 do
            local card = G.playing_cards[pseudorandom(pseudoseed('rotcard' .. i), 1, #G.playing_cards)]
            local j = 1
            while card.debuffed_by_blind do
                card = G.playing_cards[pseudorandom(pseudoseed('rotcard_reroll' .. j), 1, #G.playing_cards)]
                j = j + 1
            end
            card.debuffed_by_blind = true
            self.triggered = true
            card:set_debuff(true)
        end
    end,
    recalc_debuff = function(self, card, from_blind)
        if card.debuffed_by_blind then
            return true
        else
            return false
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
