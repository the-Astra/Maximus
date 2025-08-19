SMODS.Joker {
    key = 'monk',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            purchase_made = false,
            chips = 0,
            gain = 25
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.chips > 0 then
            return {
                chips = stg.chips
            }
        end

        if (context.buying_card or context.open_booster or context.reroll_shop) and not context.blueprint then
            stg.purchase_made = true
        end

        if context.ending_shop and not context.blueprint then
            if not stg.purchase_made then
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "chips",
                    scalar_value = "gain",
                    message_key = 'a_chips',
                    message_colour = G.C.CHIPS
                })
                return nil, true
            end
            stg.purchase_made = false
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_monk',
    type = 'loss',
    extra = { center = 'j_mxms_monk' }
}

SMODS.JimboQuip {
    key = 'wq_monk',
    type = 'win',
    extra = { center = 'j_mxms_monk' }
}
