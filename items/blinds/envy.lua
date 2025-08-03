SMODS.Blind {
    key = 'envy',
    boss = {
        min = 5,
        max = 10
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
        if context.post_trigger and context.cardarea == G.jokers and context.other_ret
            and not (context.other_context.end_of_round or context.other_context.setting_blind)
            and not G.GAME.blind.disabled then
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
            self.triggered = true
        end
    end
}
