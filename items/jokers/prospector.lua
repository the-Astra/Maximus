SMODS.Joker {
    key = 'prospector',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 15
    },
    rarity = 2,
    config = {
        extra = {
            dollars = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "pinkzigzagoon"
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return {
            vars = { stg.dollars }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, 'm_gold') then
            context.other_card.ability.h_dollars = context.other_card.ability.h_dollars + stg.dollars
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card
            }
        end
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_gold') then
                return true
            end
        end

        return false
    end
}
