SMODS.Blind {
    key = 'spring',
    loc_txt = {
        name = 'The Spring',
        text = {
            '-1 hand size',
            'per hand played'
        }
    },
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
    boss_colour = HEX('BDB087'),
    after_scoring = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.juice_up_blind()
                G.hand:change_size(-1)
                self.config.extra.hands_removed = self.config.extra.hands_removed + 1
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
