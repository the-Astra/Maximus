SMODS.Consumable {
    key = 'doppelganger',
    set = 'Spectral',
    loc_txt = {
        name = 'Doppelganger',
        text = {
            "{C:attention}Immediately{} fulfill {C:attention}all{} held", "{C:horoscope}Horoscope{} card requirements",
        },
    },
    atlas = 'Consumables',
    pos = {
        x = 0,
        y = 3
    },
    cost = 4,
    use = function(self, card, area, copier)
        for k,v in pairs(G.mxms_horoscope.cards) do
            v.config.center:succeed(v)
        end
    end,
    can_use = function(self, card)
        if #G.mxms_horoscope.cards >= 1 then
            return true
        end
        return false
    end
}
