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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    boss_colour = HEX('E87250'),
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({
                func = function()
                    self.triggered = true
                    SMODS.juice_up_blind()
                    return true;
                end
            }))
            return {
                remove = true
            }
        end
    end
}
