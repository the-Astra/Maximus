SMODS.Back {
    key = 'scarred',
    atlas = 'Modifiers',
    pos = {
        x = 3,
        y = 1
    },
    mxms_credits = {
        art = { "Inky" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    config = {
        extra = {
            slots = -1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.slots } }
    end,
    apply = function(self, back)
        G.MXMS_SCARRED_SPAWN = true
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                G.jokers:change_size(self.config.extra.slots)

                local _c = SMODS.add_card({
                    type = 'Joker',
                    no_edition = true,
                    skip_materialize = false,
                    bypass_discovery_center = true,
                    bypass_discovery_ui = true,
                    attributes = {'mxms_legendary'}
                })
                _c.mxms_scarred = true
                G.MXMS_SCARRED_SPAWN = nil
                return true;
            end
        }))
    end
}

local uc = unlock_card
function unlock_card(card)
    if not G.MXMS_SCARRED_SPAWN then
        uc(card)
    end
end

local dc = discover_card
function discover_card(card)
    if not G.MXMS_SCARRED_SPAWN then
        dc(card)
    end
end