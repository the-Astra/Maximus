SMODS.Joker {
    key = 'piggy_bank',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 15
    },
    rarity = 1,
    config = {
        extra = {
            dollars_stored = 0,
            chip_factor = 20
        }
    },
    mxms_credits = {
        art = { "pinkzigzaoon" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chip_factor, stg.dollars_stored, stg.dollars_stored * stg.chip_factor }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.money_up and not card.shattered and not context.blueprint then
            stg.dollars_stored = stg.dollars_stored + 1
            return {
                message = localize('k_upgrade_ex')
            }
        end

        if context.joker_main and stg.dollars_stored > 0 then
            return {
                chips = stg.dollars_stored * stg.chip_factor
            }
        end

        if context.out_of_money and not context.blueprint then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:shatter()
                            ease_dollars(stg.dollars_stored)
                            return true;
                        end
                    }))
                end
            }
        end
    end
}

local ed = ease_dollars
ease_dollars = function(mod, instant)
    local to_be_added = mod
    local pigs = SMODS.find_card('j_mxms_piggy_bank')
    if to_big(to_be_added) > to_big(0) and next(pigs) then
        for i, v in ipairs(pigs) do
            if not v.shattered then
                to_be_added = to_be_added - to_big(1)
            end
        end
        SMODS.calculate_context({ money_up = true })
    end

    ed(to_be_added, instant)

    G.E_MANAGER:add_event(Event({
        func = function()
            if to_big(G.GAME.dollars) <= to_big(0) then
                SMODS.calculate_context({ out_of_money = true })
            end
            return true;
        end
    }))
end
