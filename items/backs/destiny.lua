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
            return {
                vars = {
                    localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' },
                    localize { type = 'name_text', key = self.config.booster, set = 'Other' }
                }
            }
        end,
        apply = function(self, back)
            G.GAME.modifiers.mxms_horoscope_ante_end = true
        end
    }
else
    sendDebugMessage("Destiny Deck not loaded; Horoscopes Disabled", 'Maximus')
end

-- Open an Mega Horoscope Pack after each Ante (derived from Lobotomy Corporation)
local update_shopref = Game.update_shop
function Game.update_shop(self, dt)
    update_shopref(self, dt)
    if not G.GAME.modifiers.mxms_horoscope_ante_end then return end
    if G.GAME.round_resets.ante <= G.GAME.astro_last_pack then return end
    G.GAME.astro_last_pack = G.GAME.round_resets.ante
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
            if G.STATE_COMPLETE then
                local card = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
                    G.P_CENTERS["p_mxms_horoscope_mega_1"],
                    { bypass_discovery_center = true, bypass_discovery_ui = true })
                card.cost = 0
                G.FUNCS.use_card({ config = { ref_table = card } })
                card:start_materialize()
                return true
            end
        end
    }))
end
