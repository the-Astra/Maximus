SMODS.Joker {
    key = 'bear',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 14
    },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = {
        extra = {
            gain = 0.5
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
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
    end
}
