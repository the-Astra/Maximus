SMODS.Joker {
    key = 'welder',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 15
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 0.1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.individual and not context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, 'm_steel') then
            context.other_card.ability.h_x_mult = context.other_card.ability.h_x_mult + stg.Xmult
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card
            }
        end
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_steel') then
                return true
            end
        end

        return false
    end
}
