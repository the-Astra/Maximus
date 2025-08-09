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
                chip_mod = stg.chips,
                message = '+' .. stg.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.scoring_name == 'High Card' and context.individual and context.cardarea == G.play and not context.blueprint then
            stg.chips = stg.chips + context.other_card:get_chip_bonus()
            stg.temp_gain = context.other_card:get_chip_bonus()
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "Xmult",
                scalar_value = "temp_gain"
            })
            stg.temp_gain = nil
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end
    end
}
