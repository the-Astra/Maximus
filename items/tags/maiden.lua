if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'maiden',
        atlas = 'Tags',
        pos = {
            x = 4,
            y = 0
        },
        config = {
            active = false,
            discards = 2
        },
        min_ante = 2,
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        loc_vars = function(self, info_queue, tag)
            if tag.config.active then
                return { key = 'tag_mxms_maiden_active', vars = {tag.config.discards} }
            end
            return { vars = {tag.config.discards} }
        end,
        apply = function(self, tag, context)
            if context.type == 'start_apply_horoscopes' and not tag.config.active then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.GAME.round_resets.discards = G.GAME.round_resets.discards + tag.config.discards
                        ease_discard(tag.config.discards)
                        tag.config.active = true

                        attention_text({
                            text = '+',
                            colour = G.C.WHITE,
                            scale = 1,
                            hold = 0.3/G.SETTINGS.GAMESPEED,
                            cover = tag.HUD_tag,
                            cover_colour = Maximus.C.SET.Horoscope,
                            align = 'cm',
                        })

                        tag.pos.y = tag.pos.y + 1
                        tag:juice_up(0.3, 0.4)
                        play_sound('foil1', 1.2, 0.4)
                        return true;
                    end
                }))
                return true
            end

            if context.type == 'reset_horoscopes' and tag.config.active then
                tag:yep('-', Maximus.C.SET.Horoscope, function()
                    G.GAME.round_resets.discards = G.GAME.round_resets.discards - tag.config.discards
                    ease_discard(-tag.config.discards)
                    return true
                end)
                tag.triggered = true
            end
        end,
        in_pool = function(self, args)
            return false
        end
    }
else
    sendDebugMessage("Maiden Tag not loaded; Horoscopes Disabled", 'Maximus')
end
