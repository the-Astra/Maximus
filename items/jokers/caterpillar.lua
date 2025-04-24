SMODS.Joker {
    key = 'caterpillar',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            tarots = 0,
            goal = 4
        }
    },
    blueprint_compat = false,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.j_mxms_chrysalis
        return {
            vars = { stg.tarots, stg.goal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.selling_self and stg.tarots >= stg.goal and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    SMODS.add_card({
                        key = 'j_mxms_chrysalis',
                        key_append = 'cater'
                    })

                    return true;
                end
            }))
        end

        if context.using_consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
            stg.tarots = stg.tarots + 1
            SMODS.calculate_effect({ message = stg.tarots .. '/' .. stg.goal, colour = G.C.TAROT }, card)

            if stg.tarots >= stg.goal then
                local eval = function(card)
                    return not card.REMOVED
                end
                juice_card_until(card, eval, true)

                SMODS.calculate_effect({ message = localize('k_active_ex'), colour = G.C.TAROT }, card)
            end
        end
    end
}
