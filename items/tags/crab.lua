if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'crab',
        atlas = 'Tags',
        pos = {
            x = 2,
            y = 0
        },
        min_ante = 2,
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        apply = function(self, tag, context)
            if context.type == 'start_apply_horoscopes' then
                tag:yep("+", Maximus.C.SET.Horoscope, function()
                    G.GAME.mxms_cancer_bonus = G.GAME.mxms_cancer_bonus + 2
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
                    ease_hands_played(2)
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
    sendDebugMessage("Crab Tag not loaded; Horoscopes Disabled", 'Maximus')
end
