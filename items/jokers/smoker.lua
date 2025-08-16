SMODS.Joker {
    key = 'smoker',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 11
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0
        }
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            return {
                chips = stg.chips
            }
        end

        if context.scoring_name == 'High Card' and context.individual and context.cardarea == G.play and not context.blueprint then
            stg.temp_gain = context.other_card:get_chip_bonus()
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "chips",
                scalar_value = "temp_gain",
                message_colour = G.C.CHIPS
            })
            stg.temp_gain = nil
            return nil, true
        end
    end
}
