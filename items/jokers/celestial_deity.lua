SMODS.Joker {
    key = 'celestial_deity',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 12
    },
    rarity = 2,
    config = {
        extra = {
            extra_levels = 1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = false,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.extra_levels }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and context.consumeable.ability.set == 'Planet' and context.consumeable.ability.consumeable.hand_type then
            SMODS.smart_level_up_hand(card, context.consumeable.ability.consumeable.hand_type, nil, stg.extra_levels)
        end
    end,
}
