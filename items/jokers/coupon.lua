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
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { SMODS.get_probability_vars(card, stg.prob, stg.odds, 'cou') }
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
            if SMODS.pseudorandom_probability(card, 'cou', stg.prob, stg.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.card.cost = 0
                        context.card:juice_up()
                        return true
                    end
                }))
                return {
                    message = localize('k_mxms_free_ex'),
                    colour = G.C.MONEY,
                    sound = 'coin1'
                }
            else
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.SET.Tarot,
                    sound = 'tarot2'
                }
            end
        end
    end,
}
