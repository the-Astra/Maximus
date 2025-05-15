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
    calculate = function(self, card, context)
        if context.after and not G.GAME.blind.disabled then
            for k, v in pairs(context.scoring_hand) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:start_dissolve()
                        SMODS.juice_up_blind()
                        if not self.triggered then
                            self.triggered = true
                        end
                        return true;
                    end
                }))
            end
        end
    end
}
