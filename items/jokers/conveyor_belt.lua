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
    perishable_compat = false,
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

        if context.joker_main then
            if to_big(stg.chips) > to_big(0) then
                SMODS.calculate_effect({ chips = stg.chips }, context.blueprint_card or card)
            end
            if to_big(stg.mult) > to_big(0) then
                SMODS.calculate_effect({ mult = stg.mult }, context.blueprint_card or card)
            end
        end

        if context.after and not context.blueprint then
            stg.chips = (hand_chips - to_big(stg.chips)) * 0.15
            stg.mult = (mult - to_big(stg.mult)) * 0.15
            return {
                message = localize('k_mxms_pushed_ex'),
                colour = G.C.ATTENTION
            }
        end
    end
}
