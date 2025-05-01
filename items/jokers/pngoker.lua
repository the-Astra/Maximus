SMODS.Joker {
    key = 'pngoker',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 10
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            for k, v in pairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS.m_glass, nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end
            return {
                message = localize('k_mxms_glassed'),
                colour = G.C.FILTER,
                card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
