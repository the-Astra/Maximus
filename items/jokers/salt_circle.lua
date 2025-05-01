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
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral * 30 or 0, stg.gain }
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
                        { message = localize { type = 'variable', key = 'a_chips', vars = { G.GAME.consumeable_usage_total.spectral * 30 } } },
                        card)
                    SMODS.calculate_context({ scaling_card = true })
                    return true
                end
            }))
            return nil, true
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
