if Maximus_config.horoscopes then
    SMODS.Back {
        key = 'destiny',
        atlas = 'Modifiers',
        pos = {
            x = 6,
            y = 0
        },
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        config = {
            voucher = 'v_mxms_multitask',
            booster = 'p_mxms_horoscope_mega_1'
        },
        loc_vars = function(self, info_queue, back)
            local stg = self.config

            return {
                vars = {
                    localize { type = 'name_text', key = stg.voucher, set = 'Voucher' },
                    localize { type = 'name_text', key = stg.booster, set = 'Other' }
                }
            }
        end,
        apply = function(self, back)
            G.GAME.modifiers.mxms_booster_ante_end = G.GAME.modifiers.mxms_booster_ante_end or {}
            table.insert(G.GAME.modifiers.mxms_booster_ante_end, back.effect.config.booster)
        end
    }
else
    sendDebugMessage("Destiny Deck not loaded; Horoscopes Disabled", 'Maximus')
end
