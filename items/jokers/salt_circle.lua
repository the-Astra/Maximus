SMODS.Joker {
    key = 'salt_circle',
    loc_txt = {
        name = 'Salt Circle',
        text = { 
            'Gains {C:chips}+#2#{} Chips for', 
            'for every {C:spectral}Spectral{} card used',
            '{C:inactive}(Currently: {C:chips}+#1# {C:inactive}Chips)' 
        }
    },
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
                chip_mod = G.GAME.consumeable_usage_total.spectral * stg.gain,
                message = '+' .. G.GAME.consumeable_usage_total.spectral * stg.gain,
                colour = G.C.MULT,
                card = card
            }
        end

        if not context.blueprint and context.using_consumeable and context.consumeable.ability.set == "Spectral" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.calculate_effect(
                    { message = localize { type = 'variable', key = 'a_chips', vars = { G.GAME.consumeable_usage_total.spectral * 30 } } },
                        card)
                    return true
                end
            }))
            return nil, true
        end
    end
}
