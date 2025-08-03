if Maximus_config.horoscopes then
    CardSleeves.Sleeve {
        key = "destiny",
        atlas = "Sleeves",
        pos = {
            x = 3,
            y = 0
        },
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        loc_vars = function(self, info_queue, card)
            local key, vars
            if self.get_current_deck_key() == 'b_mxms_destiny' then
                key = self.key .. '_alt'
                vars = {
                    localize { type = 'name_text', key = 'v_mxms_workaholic', set = 'Voucher' },
                }
            else
                key = self.key
                vars = {
                    localize { type = 'name_text', key = 'v_mxms_multitask', set = 'Voucher' },
                    localize { type = 'name_text', key = 'p_mxms_horoscope_mega_1', set = 'Other' }
                }
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            if self.get_current_deck_key() == 'b_mxms_destiny' then
                -- If on Astro deck, apply Workaholic
                G.GAME.used_vouchers['v_mxms_workaholic'] = true
                G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        Card.apply_to_run(nil, G.P_CENTERS['v_mxms_workaholic'])
                        return true
                    end
                }))
            else
                -- Apply Multitask
                G.GAME.used_vouchers['v_mxms_multitask'] = true
                G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        Card.apply_to_run(nil, G.P_CENTERS['v_mxms_multitask'])
                        return true
                    end
                }))
                G.GAME.modifiers.mxms_horoscope_ante_end = true
            end
        end
    }
else
    sendDebugMessage("Destiny Sleeve not loaded; Horoscopes Disabled", 'Maximus')
end
