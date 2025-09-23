SMODS.Blind { --The Grinder
    key = 'grinder',
    boss = {
        min = 3,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 1
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    boss_colour = HEX('D9638D'),
    after_scoring = function(self)
        for k, v in ipairs(G.play.cards) do
            if (v.ability.set == 'Enhanced' or v.seal or v.edition) and not v.seal ~= 'mxms_black' then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        v:set_ability(G.P_CENTERS.c_base)
                        v:set_seal(nil, nil, true)
                        v:set_edition(nil, true)
                        v:juice_up(0.3, 0.4)
                        play_sound('tarot2')
                        self.triggered = true
                        return true
                    end
                }))
                SMODS.calculate_effect({ message = "Grinded" }, v)
            end
        end
    end
}
