SMODS.Blind {
    key = 'maze',
    boss = {
        min = 5,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 9
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    boss_colour = HEX('110E47'),
    calculate = function(self, card, context)
        if context.after and not G.GAME.blind.disabled then
            for i, v in ipairs(G.hand.cards) do
                if not v.debuffed_by_blind then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.25,
                        func = function()
                            v:set_debuff(true)
                            v.debuffed_by_blind = true
                            v:juice_up(0.3, 0.4)
                            play_sound('tarot2', 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3)
                            SMODS.juice_up_blind()
                            self.triggered = true
                            return true;
                        end
                    }))
                end
            end
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
