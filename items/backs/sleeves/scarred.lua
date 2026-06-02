CardSleeves.Sleeve {
    key = "scarred",
    atlas = "Sleeves",
    pos = {
        x = 0,
        y = 2
    },
    mxms_credits = {
        art = { "Inky" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_scarred' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == 'b_mxms_scarred' then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    for _, v in pairs(G.jokers.cards) do
                        if v.mxms_scarred then
                            v:set_edition('e_negative')
                            break
                        end
                    end
                    return true;
                end
            }))
        else
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
    end
}
