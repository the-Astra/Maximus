SMODS.Joker {
    key = 'salt_circle',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            gain = 30
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral * stg.gain or 0, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
            return {
                chips = G.GAME.consumeable_usage_total.spectral * stg.gain
            }
        end

        if not context.blueprint and context.using_consumeable and context.consumeable.ability.set == "Spectral" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_chips', vars = { G.GAME.consumeable_usage_total.spectral * stg.gain } } },
                        card)
                    SMODS.calculate_context({ mxms_scaling_card = true })
                    return true
                end
            }))
            return nil, true
        end
    end
}
