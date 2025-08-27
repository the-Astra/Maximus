SMODS.Joker {
    key = 'stone_thrower',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 9
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0,
            gain = 30
        }
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    enhancement_gate = 'm_glass',
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {
            vars = { stg.chips, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.chips > 0 then
            return {
                chip_mod = stg.chips,
                message = '+' .. stg.chips,
                colour = G.C.CHIPS
            }
        end

        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_glass') and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "chips",
                scalar_value = "gain",
                message_colour = G.C.CHIPS
            })
            return nil, true
        end

        if context.fix_probability and context.identifier == 'glass' then
            return {
                numerator = 1,
                denominator = 1
            }
        end
    end
}
