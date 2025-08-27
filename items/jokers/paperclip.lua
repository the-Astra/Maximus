SMODS.Joker {
    key = 'paperclip',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            gain = 1
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.pre_reroll then
            stg.temp_gain = stg.gain * #G.shop_jokers.cards
            if stg.temp_gain > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = 'extra_value',
                    scalar_table = stg,
                    scalar_value = 'temp_gain',
                    scaling_message = {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }
                })
                card:set_cost()
                return nil, true
            end
        end
    end
}
