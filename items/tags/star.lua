if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'star',
        atlas = 'Tags',
        pos = {
            x = 0,
            y = 0
        },
        min_ante = 2,
        config = {
            type = 'new_blind_choice'
        },
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        loc_vars = function(self, info_queue)
            info_queue[#info_queue + 1] = { set = "Other", key = "p_mxms_horoscope_mega_1", specific_vars = { 2, 4 } }
        end,
        apply = function(self, tag, context)
            if context.type == "new_blind_choice" then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep("+", Maximus.C.SET.Horoscope, function()
                    local booster = SMODS.create_card { key = "p_mxms_horoscope_mega_1", area = G.play, discover = true }
                    booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                    booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                    booster.T.w = G.CARD_W * 1.27
                    booster.T.h = G.CARD_H * 1.27
                    booster.cost = 0
                    booster.from_tag = true
                    G.FUNCS.use_card({ config = { ref_table = booster } })
                    booster:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    }
else
    sendDebugMessage("Star Tag not loaded; Horoscopes Disabled", 'Maximus')
end
