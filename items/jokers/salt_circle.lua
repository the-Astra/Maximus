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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { G.GAME.consumeable_usage_total.spectral * stg.gain } },
                colour = G.C.CHIPS
            }
        end
    end
}
