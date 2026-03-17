if Maximus_config.conspiracies then
    CardSleeves.Sleeve {
        key = "censored",
        atlas = "Sleeves",
        pos = {
            x = 0,
            y = 0
        },
        mxms_credits = {
            art = { "???" },
            code = { "theAstra" },
            idea = { "theAstra" }
        },
        loc_vars = function(self, info_queue, card)
            local key
            local vars
            if self.get_current_deck_key() == 'b_mxms_censored' then
                key = self.key .. '_alt'
                vars = { localize { type = 'name_text', key = 'v_mxms_whistleblower', set = 'Voucher' } }
            else
                key = self.key
                vars = localize { type = 'name_text', key = 'p_mxms_classified_mega_1', set = 'Other' }
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            if self.get_current_deck_key() == 'b_mxms_censored' then
                -- If on Censored deck, apply Whistleblower
                G.GAME.used_vouchers['v_mxms_whistleblower'] = true
                G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        Card.apply_to_run(nil, G.P_CENTERS['v_mxms_whistleblower'])
                        return true
                    end
                }))
            else
                G.GAME.modifiers.mxms_booster_ante_end = G.GAME.modifiers.mxms_booster_ante_end or {}
                table.insert(G.GAME.modifiers.mxms_booster_ante_end, 'p_mxms_classified_mega_1')
            end
        end
    }
end
