SMODS.Joker {
    key = 'maurice',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 17
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.stay_flipped and context.from_area == G.play and SMODS.has_enhancement(context.other_card, 'm_wild') then
            return {
                modify = { to_area = G.deck },
                message = localize('k_saved_ex'),
                sound = 'mxms_joker'
            }
        end
    end
}
