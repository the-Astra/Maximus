if Maximus_config.horoscopes then
    SMODS.Tag {
        key = 'scale',
        atlas = 'Tags',
        pos = {
            x = 5,
            y = 0
        },
        min_ante = 2,
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" },
            idea = { "Maxiss02" }
        },
        apply = function(self, tag, context)
            if context.type == 'shop_final_pass' then
                G.GAME.shop_free = true
                tag:yep("+", Maximus.C.SET.Horoscope, function()
                    SMODS.change_free_rerolls(1)
                    calculate_reroll_cost(true)
                    if G.shop_jokers then
                        for k, v in pairs(G.shop_jokers.cards) do
                            v.ability.couponed = true
                            v:set_cost()
                        end
                    end
                    if G.shop_booster then
                        for k, v in pairs(G.shop_booster.cards) do
                            v.ability.couponed = true
                            v:set_cost()
                        end
                    end
                    if G.shop_vouchers then
                        for k, v in pairs(G.shop_vouchers.cards) do
                            v.cost = 0
                            create_shop_card_ui(v)
                        end
                    end
                    return true
                end)
                SMODS.change_free_rerolls(-1)
                tag.triggered = true
                return true
            end
        end,
        in_pool = function(self, args)
            return false
        end
    }
else
    sendDebugMessage("Scale Tag not loaded; Horoscopes Disabled", 'Maximus')
end
