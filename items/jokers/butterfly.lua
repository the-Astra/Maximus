SMODS.Joker {
    key = 'butterfly',
    loc_txt = {
        name = 'Butterfly',
        text = { 'Creates a {C:spectral}Spectral{} Card,', 'every {C:attention}#2#{} consumables used', '{C:inactive}Currently: #1#/#2#' }
    },
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            consumables = 0,
            goal = 6
        }
    },
    blueprint_compat = true,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.consumables, stg.goal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and not context.blueprint then
            stg.consumables = stg.consumables + 1
            SMODS.calculate_effect({ message = stg.consumables .. '/' .. stg.goal, colour = G.C.PLANET }, card)

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
    end
}
