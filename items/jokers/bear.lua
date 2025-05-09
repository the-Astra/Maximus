SMODS.Joker {
    key = 'bear',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = {
        extra = {
            gain = 0.5
        }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local xmult = 1

        if to_big(G.GAME.dollars) < to_big(0) then
            xmult = xmult + (math.abs(G.GAME.dollars) * stg.gain)
        end

        return {
            vars = { stg.gain, xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and to_big(G.GAME.dollars) < to_big(0) then
            return {
                x_mult = 1 + math.abs(G.GAME.dollars) * stg.gain
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
