if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'ram',
        atlas = 'Tags',
        pos = {
            x = 1,
            y = 0
        },
        min_ante = 2,
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        apply = function(self, tag, context)
            if context.type == 'start_apply_horoscopes' and not G.GAME.mxms_aries_bonus then
                G.GAME.mxms_aries_bonus = true
                tag:yep("+", Maximus.C.SET.Horoscope, function()
                    return true
                end)
                tag.triggered = true
                return true
            end
        end,
        in_pool = function(self, args)
            return false
        end
    }
else
    sendDebugMessage("Ram Tag not loaded; Horoscopes Disabled", 'Maximus')
end
