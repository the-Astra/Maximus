SMODS.Blind {
    key = 'envy',
    boss = {
        min = 5
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 2
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    boss_colour = HEX('4CCAA9'),
    calculate = function(self, card, context)
        if context.post_trigger and context.other_ret
            and not (context.other_context.end_of_round or context.other_context.setting_blind)
            and not G.GAME.blind.disabled then
            self.triggered = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.juice_up_blind()
                            return true;
                        end
                    }))
            return {
                delay = 0.25,
                dollars = -1
            }
        end
    end
}
