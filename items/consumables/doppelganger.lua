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
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        can_use = function(self, card)
            if #G.mxms_horoscope.cards >= 1 then
                return true
            end
            return false
        end
    }
else
    sendDebugMessage("Doppelganger not loaded; Horoscopes Disabled", 'Maximus')
end
