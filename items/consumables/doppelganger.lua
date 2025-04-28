if Maximus_config.horoscopes then
    SMODS.Consumable {
        key = 'doppelganger',
        set = 'Spectral',
        atlas = 'Consumables',
        pos = {
            x = 0,
            y = 3
        },
        cost = 4,
        use = function(self, card, area, copier)
            for k, v in pairs(G.mxms_horoscope.cards) do
                v.config.center:succeed(v)
            end
        end,
        can_use = function(self, card)
            if #G.mxms_horoscope.cards >= 1 then
                return true
            end
            return false
        end,
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    }
else
    sendDebugMessage("Doppelganger not loaded; Horoscopes Disabled", 'Maximus')
end
