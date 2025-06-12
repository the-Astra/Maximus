SMODS.Joker {
    key = 'coupon',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            prob = 1,
            odds = 10
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.prob * G.GAME.probabilities.normal, stg.odds }
        }
    end,
    set_ability = function(self, card, inital, delay_sprites)
        local W = card.T.w
        W = W * (63 / 71)
        card.children.center.scale.x = card.children.center.scale.x * (63 / 71)
        card.T.w = W
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.mxms_joker_cost_check and context.card.cost ~= 0 then
            if pseudorandom('cou' .. G.GAME.round_resets.ante, stg.prob * G.GAME.probabilities.normal, stg.odds) == stg.odds then
                context.card.cost = 0
                card:juice_up(0.3, 0.4)
            else
                SMODS.calculate_effect({ message = localize('k_nope_ex'), colour = G.C.SET.Tarot, sound = 'tarot2' }, card)
                SMODS.calculate_context({ mxms_failed_prob = true, odds = stg.odds - (stg.prob * G.GAME.probabilities.normal) })
            end
        end
    end,
}
