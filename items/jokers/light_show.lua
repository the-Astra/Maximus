SMODS.Joker {
    key = 'light_show',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 4
    },
    config = {
        extra = {
            reps = 1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return {}
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.repetition and context.cardarea == G.play and
            (SMODS.has_enhancement(context.other_card, 'm_bonus') or
            SMODS.has_enhancement(context.other_card, 'm_mult')) then
            return {
                message = localize('k_again_ex'),
                repetitions = stg.reps,
                card = card
            }
        end
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_bonus') or SMODS.has_enhancement(v, 'm_mult') then
                return true
            end
        end

        return false
    end
}

SMODS.JimboQuip {
    key = 'lq_light_show',
    type = 'loss',
    extra = { center = 'j_mxms_light_show' }
}

SMODS.JimboQuip {
    key = 'wq_light_show',
    type = 'win',
    extra = { center = 'j_mxms_light_show' }
}
