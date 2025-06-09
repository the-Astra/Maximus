SMODS.Blind {
    key = 'flame',
    boss = {
        min = 6,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 3
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "theAstra"
    },
    boss_colour = HEX('E87250'),
    after_scoring = function(self)
        for k, v in pairs(context.scoring_hand) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    v:start_dissolve()
                    SMODS.juice_up_blind()
                    self.triggered = true
                    return true;
                end
            }))
        end
    end
}
