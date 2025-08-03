SMODS.Joker {
    key = 'hedonist',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 5
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
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
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
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

        if context.ending_shop and #G.shop_vouchers.cards == 0 and #G.shop_booster.cards == 0 and #G.shop_jokers.cards == 0 and not context.blueprint then
            stg.Xmult = stg.Xmult + stg.gain * G.GAME.mxms_soil_mod
            SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_xmult', vars = { stg.Xmult } } },
                context.blueprint_card or card)
            SMODS.calculate_context({ mxms_scaling_card = true })
        end
    end
}
