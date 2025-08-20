SMODS.Joker {
    key = 'lint',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 14
    },
    rarity = 1,
    config = {
        extra = {
            sub = 1
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.sub }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if G.STATE == G.STATES.SHOP and context.selling_card and string.sub(context.card.config.center_key, 1, 2) == 'c_' then
            for k, v in pairs(G.shop_jokers.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up()
                                v.cost = v.cost - stg.sub >= 0 and v.cost - stg.sub or 0
                                return true;
                            end
                        }))
                        local reduction = v.cost - stg.sub >= 0 and stg.sub or v.cost
                        SMODS.calculate_effect({
                            message = '-' .. localize('$') .. reduction,
                            colour = G.C.MONEY,
                            sound = 'coin1'
                        }, v)
                        return true;
                    end
                }))
            end

            for k, v in pairs(G.shop_vouchers.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up()
                                v.cost = v.cost - stg.sub >= 0 and v.cost - stg.sub or 0
                                return true;
                            end
                        }))
                        local reduction = v.cost - stg.sub >= 0 and stg.sub or v.cost
                        SMODS.calculate_effect({
                            message = '-' .. localize('$') .. reduction,
                            colour = G.C.MONEY,
                            sound = 'coin1'
                        }, v)
                        return true;
                    end
                }))
            end

            for k, v in pairs(G.shop_booster.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                (context.blueprint_card or card):juice_up()
                                v.cost = v.cost - stg.sub >= 0 and v.cost - stg.sub or 0
                                return true;
                            end
                        }))
                        local reduction = v.cost - stg.sub >= 0 and stg.sub or v.cost
                        SMODS.calculate_effect({
                            message = '-' .. localize('$') .. reduction,
                            colour = G.C.MONEY,
                            sound = 'coin1'
                        }, v)
                        return true;
                    end
                }))
            end
        end
    end
}
