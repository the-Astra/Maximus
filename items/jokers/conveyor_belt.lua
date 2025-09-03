SMODS.Joker {
    key = 'conveyor_belt',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 12
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0,
            mult = 0
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and to_big(stg.chips) > to_big(0) and to_big(stg.mult) > to_big(0) then
            SMODS.calculate_effect({ chips = to_number(stg.chips) }, context.blueprint_card or card)
            SMODS.calculate_effect({ mult = to_number(stg.mult) }, context.blueprint_card or card)
        end

        if context.after and not context.blueprint then
            stg.chips = hand_chips * 0.15
            stg.mult = mult * 0.15
            return {
                message = localize('k_mxms_pushed_ex'),
                colour = G.C.ATTENTION
            }
        end
    end
}
