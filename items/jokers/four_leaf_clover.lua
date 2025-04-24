SMODS.Joker {
    key = 'four_leaf_clover',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 2
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 7,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and #context.scoring_hand == 4 then
            -- Code derived from Midas Mask
            for k, v in ipairs(context.scoring_hand) do
                if not v.debuff then
                    v:set_ability(G.P_CENTERS.m_lucky, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up(0.3, 0.4)
                            return true
                        end
                    }))
                end
            end

            return {
                message = localize('k_mxms_lucky'),
                colour = G.C.GREEN,
                card = card
            }
        end
    end
}
