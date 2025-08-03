SMODS.Joker {
    key = 'caterpillar',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 16
    },
    rarity = 1,
    config = {
        extra = {
            tarots = 0,
            goal = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
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

        if context.using_consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
            stg.tarots = stg.tarots + 1
            SMODS.calculate_effect({ message = stg.tarots .. '/' .. stg.goal, colour = G.C.TAROT }, card)

            if stg.tarots >= stg.goal then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        card:set_ability('j_mxms_chrysalis')
                        card:juice_up(0.8, 0.8)
                        play_sound('tarot1')
                        return true;
                    end
                }))
            end
        end
    end,
    in_pool = function(self, args)
        local lineage = next(SMODS.find_card('j_mxms_chrysalis')) and next(SMODS.find_card('j_mxms_butterfly'))
        if lineage then
            lineage = not next(SMODS.find_card('j_ring_master'))
        end
        return not lineage
    end,
}
