SMODS.Tag {
    key = 'star',
    loc_txt = {
        name = 'Star Tag',
        text = {
            "Gives a free",
            "{C:horoscope}Mega Zodiac Pack",
        },
    },
    atlas = 'Tags',
    pos = {
        x = 0,
        y = 0
    },
    min_ante = 2,
    config = {
        type = 'new_blind_choice'
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { set = "Other", key = "p_mxms_horoscope_mega_1", specific_vars = { 1, 2 } }
    end,
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
            tag:yep("+", G.C.SECONDARY_SET.Horoscope, function()
                local key = "p_mxms_horoscope_mega_1"
                local card = Card(
                    G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                    G.CARD_W * 1.27,
                    G.CARD_H * 1.27,
                    G.P_CARDS.empty,
                    G.P_CENTERS[key],
                    { bypass_discovery_center = true, bypass_discovery_ui = true }
                )
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = card } })
                card:start_materialize()
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
