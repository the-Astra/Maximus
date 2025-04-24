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

        if context.ending_shop then
            if not stg.purchase_made then
                stg.chips = stg.chips + stg.gain
                SMODS.calculate_effect(
                    { message = localize { type = 'variable', key = 'a_chips', vars = { stg.chips } } },
                    card)
                SMODS.calculate_context({ scaling_card = true })
            end
            stg.purchase_made = false
        end
    end
}
