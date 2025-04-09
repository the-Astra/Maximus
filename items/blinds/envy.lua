SMODS.Blind {
    key = 'envy',
    loc_txt = {
        name = 'The Envy',
        text = {
            '{C:money}-$1{} for every',
            'Joker trigger'
        }
    },
    boss = {
        min = 5,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 2
    },
    boss_colour = HEX('4CCAA9'),
    calculate = function(self, card, context)
        if context.post_trigger and context.other_ret and not context.other_context.end_of_round and not G.GAME.blind.disabled then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    SMODS.juice_up_blind()
                    return true;
                end
            }))
            delay(0.23)
            ease_dollars(-1)
            if not self.triggered then
                self.triggered = true
            end
        end
    end
}
