if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'lion',
        atlas = 'Tags',
        pos = {
            x = 3,
            y = 0
        },
        config = {
            active = false,
            hand_size = 3
        },
        min_ante = 2,
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        loc_vars = function(self, info_queue, tag)
            if tag.config.active then
                return { key = 'tag_mxms_lion_active', vars = {tag.config.hand_size} }
            end
            return { vars = {tag.config.hand_size} }
        end,
        apply = function(self, tag, context)
            if context.type == 'start_apply_horoscopes' and not tag.config.active then
                Maximus.activate_horoscope_tag(tag)
                G.hand:change_size(tag.config.hand_size)
            end

            if context.type == 'reset_horoscopes' and tag.config.active then
                tag:yep('-', Maximus.C.SET.Horoscope, function()
                    return true
                end)
                G.hand:change_size(-tag.config.hand_size)
                tag.triggered = true
            end
        end,
        in_pool = function(self, args)
            return false
        end
    }
else
    sendDebugMessage("Lion Tag not loaded; Horoscopes Disabled", 'Maximus')
end
