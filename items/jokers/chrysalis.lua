SMODS.Joker {
    key = 'chrysalis',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 16
    },
    rarity = 1,
    config = {
        extra = {
            planets = 0,
            goal = 4
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
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

        if context.using_consumeable and context.consumeable.ability.set == 'Planet' and not context.blueprint then
            stg.planets = stg.planets + 1
            SMODS.calculate_effect({ message = stg.planets .. '/' .. stg.goal, colour = G.C.PLANET }, card)

            if stg.planets >= stg.goal then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        card:set_ability('j_mxms_butterfly')
                        card:juice_up(0.8, 0.8)
                        play_sound('tarot1')
                        return true;
                    end
                }))
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
