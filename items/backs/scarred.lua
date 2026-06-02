SMODS.Back {
    key = 'scarred',
    atlas = 'Placeholder',
    pos = {
        x = 4,
        y = 2
    },
    mxms_credits = {
        art = { "Inky" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                local _c = SMODS.add_card({
                    type = 'Joker',
                    no_edition = true,
                    skip_materialize = false,
                    bypass_discovery_center = true,
                    bypass_discovery_ui = true,
                    attributes = {'mxms_legendary'}
                })
                _c.mxms_scarred = true
                return true;
            end
        }))
    end
}
