SMODS.Back {
    key = 'dummy',
    atlas = 'Modifiers',
    pos = {
        x = 1,
        y = 1
    },
    config = {
        money_cap = 50
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, back)
        local modifier = G.GAME.dollars and G.GAME.dollars > 0 and G.GAME.dollars or 0
        return { vars = { self.config.money_cap, modifier } }
    end,
    apply = function(self, back)
        --Change shop prices
        G.GAME.mxms_money_cap = self.config.money_cap
    end,
    calculate = function(self, back, context)
        if context.setting_blind then
            local modifier = G.GAME.dollars and G.GAME.dollars > 0 and G.GAME.dollars / 100 or 0
            if modifier > 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        play_sound('chips2'); return true
                    end)
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    blocking = false,
                    ref_table = G.GAME,
                    ref_value = 'chips',
                    ease_to = math.floor(G.GAME.blind.chips * modifier),
                    delay = 0.5,
                    func = (function(t) return math.floor(t) end)
                }))
                return {
                    message = (modifier * 100) .. '%',
                    colour = G.C.PURPLE
                }
            end
        end
    end
}

local ed = ease_dollars
function ease_dollars(mod, instant)
    if G.GAME.mxms_money_cap and G.GAME.dollars + mod > G.GAME.mxms_money_cap then
        mod = mod + (G.GAME.mxms_money_cap - (G.GAME.dollars + mod))
    end
    ed(mod, instant)
end
