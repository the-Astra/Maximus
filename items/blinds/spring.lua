SMODS.Blind {
    key = 'spring',
    boss = {
        min = 1,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 7
    },
    config = {
        extra = {
            hands_removed = 0
        }
    },
    credit = {
        art = "pinkzigzagoon",
        code = "theAstra",
        concept = "pinkzigzagoon"
    },
    boss_colour = HEX('BDB087'),
    after_scoring = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.juice_up_blind()
                G.hand:change_size(-1)
                self.config.extra.hands_removed = self.config.extra.hands_removed + 1
                self.triggered = true
                return true;
            end
        }))
    end,
    disable = function(self)
        G.hand:change_size(self.config.extra.hands_removed)
    end,
    defeat = function(self)
        if not G.GAME.blind.disabled then
            G.hand:change_size(self.config.extra.hands_removed)
        end
    end
}
