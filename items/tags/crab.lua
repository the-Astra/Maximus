if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'crab',
        atlas = 'Tags',
        pos = {
            x = 2,
            y = 0
        },
        config = {
            active = false,
            hands = 2
        },
        min_ante = 2,
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        loc_vars = function(self, info_queue, tag)
            if tag.config.active then
                return { key = 'tag_mxms_crab_active', vars = {tag.config.hands} }
            end
            return { vars = {tag.config.hands} }
        end,
        apply = function(self, tag, context)
            if context.type == 'start_apply_horoscopes' and not tag.config.active then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.GAME.round_resets.hands = G.GAME.round_resets.hands + tag.config.hands
                        ease_hands_played(2)
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
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands - tag.config.hands
                    ease_hands_played(-tag.config.hands)
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
    sendDebugMessage("Crab Tag not loaded; Horoscopes Disabled", 'Maximus')
end
