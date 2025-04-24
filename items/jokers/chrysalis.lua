SMODS.Joker {
    key = 'chrysalis',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            planets = 0,
            goal = 5
        }
    },
    blueprint_compat = false,
    unlocked = false,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        if not card.fake_card then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_mxms_butterfly
        end
        return {
            vars = { stg.planets, stg.goal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.selling_self and stg.planets >= stg.goal and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    SMODS.add_card({
                        key = 'j_mxms_butterfly',
                        key_append = 'chrys'
                    })

                    return true;
                end
            }))
        end

        if context.using_consumeable and context.consumeable.ability.set == 'Planet' and not context.blueprint then
            stg.planets = stg.planets + 1
            SMODS.calculate_effect({ message = stg.planets .. '/' .. stg.goal, colour = G.C.PLANET }, card)

            if stg.planets >= stg.goal then
                local eval = function(card)
                    return not card.REMOVED
                end
                juice_card_until(card, eval, true)

                SMODS.calculate_effect({ message = localize('k_active_ex'), colour = G.C.PLANET }, card)
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    check_for_unlock = function(self, args)
        return next(SMODS.find_card('j_mxms_chrysalis'))
    end
}
