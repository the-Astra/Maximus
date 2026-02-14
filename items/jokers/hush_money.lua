SMODS.Joker {
    key = 'hush_money',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 18
    },
    rarity = 3,
    config = {
        extra = {
            money = 20,
            reduction = 2
        }
    },
    mxms_credits = {
        art = { "GhostSalt" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = false,
    perishable_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.money, stg.reduction }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and context.consumeable.ability.set == 'Conspiracy' and not context.blueprint then
            stg.money = stg.money - stg.reduction
            return {
                message = '-' .. localize('$') .. stg.reduction,
                colour = G.C.RED,
                func = function()
                    if stg.money <= 0 then
                        SMODS.destroy_cards(card, nil, nil, true)
                    end
                end
            }
        end

        if context.selling_card and context.card.ability.set == 'Conspiracy' and not context.blueprint then
            stg.money = stg.money - stg.reduction
            return {
                message = '-' .. localize('$') .. stg.reduction,
                colour = G.C.RED,
                func = function()
                    if stg.money <= 0 then
                        SMODS.destroy_cards(card, nil, nil, true)
                    end
                end
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        local stg = card.ability.extra
        return stg.money
    end
}
