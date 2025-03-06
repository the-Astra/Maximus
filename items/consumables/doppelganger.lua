SMODS.Consumable {
    key = 'doppelganger',
    set = 'Spectral',
    loc_txt = {
        name = 'Doppelganger',
        text = {
            "{C:attemtion}Immediately{} fulfill {C:attention}1{} selected", "{C:horoscope}Horoscope{} card's requirement",
        },
    },
    atlas = 'Placeholder',
    pos = {
        x = 2,
        y = 2
    },
    cost = 4,
    use = function(self, card, area, copier)
        G.mxms_horoscope.highlighted[1].config.center:succeed(G.mxms_horoscope.highlighted[1])
    end,
    can_use = function(self, card)
        if G.mxms_horoscope and #G.mxms_horoscope.highlighted == 1 and G.mxms_horoscope.highlighted[1] then
            return true
        end
        return false
    end
}
