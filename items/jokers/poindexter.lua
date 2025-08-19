SMODS.Joker {
    key = 'poindexter',
    atlas = 'Jokers',
    rarity = 2,
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            Xmult = 1.0,
            gain = 0.25
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 7,
    enhancement_gate = 'm_glass',
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end

        if context.after and not context.blueprint then
            -- Check for shattered glass
            for k, v in pairs(context.scoring_hand) do
                if v.glass_trigger then
                    return {
                        message = localize('k_mxms_erm_el')
                    }
                end
            end

            -- If no shattered glass, add to mult
            local glass = 0
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, 'm_glass') then
                    glass = glass + 1
                end
            end
            stg.Xmult = stg.Xmult + glass * stg.gain
            return {
                message = localize('k_mxms_eureka_ex'),
                colour = G.C.ATTENTION,
                func = function() SMODS.calculate_context({ mxms_scaling_card = true }) end
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_poindexter',
    type = 'loss',
    extra = { center = 'j_mxms_poindexter' }
}

SMODS.JimboQuip {
    key = 'wq_poindexter',
    type = 'win',
    extra = { center = 'j_mxms_poindexter' }
}