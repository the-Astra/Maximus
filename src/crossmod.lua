--#region Talisman compat -----------------------------------------------------------------------------------

to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end

--#endregion

--#region TheFamily compat ----------------------------------------------------------------------------------
if TheFamily then
    TheFamily.create_tab_group({
        key = "Maximus",
        order = 1,
    })
    TheFamily.create_tab({
        key = "horoscope",
        group_key = "Maximus",
        type = "switch",
        keep = true,

        front_label = function(definition, card)
            return {
                text = localize('b_mxms_stat_horoscopes'),
                colour = Maximus.C.HOROSCOPE,
                scale = 0.5,
            }
        end,
        center = "c_mxms_taurus",

        popup = function(definition, card)
            return {
                name = {
                    {
                        n = G.UIT.T,
                        config = {
                            text = localize('b_mxms_stat_horoscopes'),
                            colour = Maximus.C.HOROSCOPE,
                            scale = 0.4,
                        },
                    },
                },
                description = {
                    {
                        {
                            n = G.UIT.T,
                            config = {
                                text = "Show/Hide the Maximus Horoscope card area",
                                scale = 0.3,
                                colour = G.C.BLACK,
                            },
                        },
                    },
                },
            }
        end,
        keep_popup_when_highlighted = false,
        alert = function(definition, card)
            if not G.GAME.horoscope_alert or G.mxms_horoscope.states.visible then
                G.GAME.horoscope_alert = false
                return {
                    remove = true,
                }
            end
            return {
                text = "!",
            }
        end,
        highlight = function(definition, card)
            if Maximus_config.horoscopes then
                G.mxms_horoscope.states.visible = true
                G.GAME.horoscope_alert = false
            end
        end,
        unhighlight = function(definition, card)
            if Maximus_config.horoscopes then
                G.mxms_horoscope.states.visible = false
            end
        end,
    })
end
--#endregion

--#region JokerDisplay compat -------------------------------------------------------------------------------
if JokerDisplay then
    assert(SMODS.load_file("jd_def.lua"))()
end
--#endregion

--#region PlayLog compat -----------------------------------------------------------------------------------
if PlayLog then
    PlayLog.LogType {
        key = 'mxms_horoscope_success',
        group = "effects",
        get_message = function(self, args)
            return PlayLog.localize(self.key, {PlayLog.format_object(args.card)})
        end
    }

    PlayLog.LogType {
        key = 'mxms_horoscope_fail',
        group = "effects",
        get_message = function(self, args)
            return PlayLog.localize(self.key, {PlayLog.format_object(args.card)})
        end
    }

    PlayLog.LogType {
        key = 'mxms_horoscope_increment',
        group = "effects",
        get_message = function(self, args)
            return PlayLog.localize(self.key, {PlayLog.format_object(args.card), args.tally - 1, args.tally})
        end
    }

    local plgan = PlayLog.get_area_name
    PlayLog.get_area_name = function(area)
        if area == G.mxms_horoscope then
            return PlayLog.localize('horoscope_area')
        end
        return plgan(area)
    end
end
--#endregion
