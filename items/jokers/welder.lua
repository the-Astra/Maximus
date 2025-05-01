SMODS.Joker {
    key = 'welder',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 0.1
        }
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

        if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, 'm_steel') then
            context.other_card.ability.h_x_mult = context.other_card.ability.h_x_mult + stg.Xmult
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
