SMODS.Joker {
    key = 'pngoker',
    loc_txt = {
        name = 'PNGoker',
        text = { 'All cards in your', '{C:attention}first played hand{}', 'become {C:attention}glass{}' }
    },
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
                message = "Glassed",
                colour = G.C.FILTER,
                card = card
            }
        end
    end
}
