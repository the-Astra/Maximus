SMODS.Joker { -- Man in the Mirror
    key = 'man_in_the_mirror',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 3
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 8,
    rarity = 2,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            card:shatter()
            -- Fail if no held consumeables
            if next(G.consumeables.cards) == nil then
                return {
                    message = localize('k_mxms_no_target_el'),
                    colour = G.C.PURPLE
                }
            else
                -- Add negative edition to all held consumeables
                for k, v in ipairs(G.consumeables.cards) do
                    if not (v.edition and v.edition.negative) then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                local new_card = copy_card(v, nil, nil, nil, v.edition and v.edition.negative)
                                new_card:set_edition({
                                    negative = true
                                }, true)
                                new_card:start_materialize()
                                new_card:add_to_deck()
                                G.consumeables:emplace(new_card)
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}
