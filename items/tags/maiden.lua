if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'maiden',
        atlas = 'Tags',
        pos = {
            x = 4,
            y = 0
        },
        min_ante = 2,
        credit = {
            art = "Maxiss02",
            code = "theAstra",
            concept = "Maxiss02"
        },
        apply = function(self, tag, context)
            if context.type == 'start_apply_horoscopes' then
                tag:yep("+", G.C.SECONDARY_SET.Horoscope, function()
                    G.GAME.virgo_bonus = G.GAME.virgo_bonus + 3
                    G.GAME.round_resets.discards = G.GAME.round_resets.discards + 3
                    ease_discard(3)
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
    sendDebugMessage("Maiden Tag not loaded; Horoscopes Disabled", 'Maximus')
end
