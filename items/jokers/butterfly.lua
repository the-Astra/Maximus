SMODS.Joker {
    key = 'butterfly',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 17
    },
    rarity = 1,
    config = {
        extra = {
            consumables = 0,
            goal = 5
        }
    },
    mxms_credits = {
        art = "Maxiss02",
        code = "theAstra",
        idea = "pinkzigzagoon"
    },
    blueprint_compat = true,
    unlocked = false,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.consumables, stg.goal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable then
            if not context.blueprint then
                stg.consumables = stg.consumables + 1
                SMODS.calculate_effect({ message = stg.consumables .. '/' .. stg.goal, colour = G.C.PLANET }, card)
            end

            if stg.consumables >= stg.goal then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        SMODS.add_card({
                            set = 'Spectral',
                            key_append = 'butterfly'
                        })

                        stg.consumables = 0

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
        return next(SMODS.find_card('j_mxms_butterfly'))
    end
}
