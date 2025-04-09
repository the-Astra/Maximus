SMODS.Blind {
    key = 'flame',
    loc_txt = {
        name = 'The Flame',
        text = {
            'All scored cards are',
            'destroyed after scoring'
        }
    },
    boss = {
        min = 6,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 3
    },
    boss_colour = HEX('E87250'),
    calculate = function(self, card, context)
        if context.after then
            for k, v in pairs(context.scoring_hand) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:start_dissolve()
                        SMODS.juice_up_blind()
                        return true;
                    end
                }))
            end
        end
    end
}
