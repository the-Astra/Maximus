CardSleeves.Sleeve {
    key = "dummy",
    atlas = "Sleeves",
    pos = {
        x = 2,
        y = 1
    },
    config = {
        money_cap = 50,
        limit = 75,
        gain = 1
    },
    mxms_credits = {
        art = { "theAstra" },
        code = { "theAstra" },
        idea = { "lord.ruby" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        local vars
        if self.get_current_deck_key() == 'b_mxms_dummy' then
            key = self.key .. '_alt'
            vars = { G.GAME.mxms_money_cap or self.config.money_cap, self.config.gain, self.config.limit }
        else
            local modifier = G.GAME.dollars and G.GAME.dollars > 0 and G.GAME.dollars or 0
            key = self.key
            vars = { self.config.money_cap, modifier }
        end
        return { key = key, vars = vars }
    end,
    calculate = function(self, sleeve, context)
        if context.end_of_round and not context.individual and not context.repetition and self.get_current_deck_key() == 'b_mxms_dummy' and G.GAME.dollars then
            if G.GAME.dollars == G.GAME.mxms_money_cap and G.GAME.mxms_money_cap ~= self.config.limit then
                G.GAME.mxms_money_cap = G.GAME.mxms_money_cap + self.config.gain
                return {
                    message = localize('k_upgrade_ex')
                }
            elseif G.GAME.dollars < G.GAME.mxms_money_cap then
                G.GAME.mxms_money_cap = self.config.money_cap
                return {
                    message = localize('k_reset')
                }
            end
        end

        if context.setting_blind and not self.get_current_deck_key() == 'b_mxms_dummy' then
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
