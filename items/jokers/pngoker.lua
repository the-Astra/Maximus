SMODS.Joker {
    key = 'pngoker',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 10
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    rarity = 3,
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
    end
}

SMODS.JimboQuip {
    key = 'wq_pngoker',
    type = 'loss',
    extra = { center = 'j_mxms_pngoker' }
}