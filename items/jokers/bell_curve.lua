SMODS.Joker {
    key = 'bell_curve',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local calc = 3
        if G.playing_cards ~= nil then
            calc = 2 * math.exp(-(((#G.playing_cards - 52) ^ 2) / 250)) + 1
        end
        return {
            vars = { calc }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            stg.Xmult = 2 * math.exp(-(((#G.playing_cards - 52) ^ 2) / 250)) + 1
            return {
                x_mult = stg.Xmult,
            }
        end
    end
}
