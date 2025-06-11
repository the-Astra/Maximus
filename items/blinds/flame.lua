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
        if context.after then
            local destroyed_cards = {}
            for k, v in pairs(context.scoring_hand) do
                destroyed_cards[#destroyed_cards + 1] = v
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        destroyed_cards[#destroyed_cards+1] = v
                        v:start_dissolve()
                        SMODS.juice_up_blind()
                        self.triggered = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:remove()
                                v = nil
                                return true;
                            end
                        }))
                        return true;
                    end
                }))
            end
            SMODS.calculate_context({ remove_playing_card = true, removed = destroyed_cards })
        end
    end
}
