SMODS.Joker {
    key = 'wild_buddy',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 13
    },
    rarity = 1,
    config = {
        extra = {
            Xmult = 2
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.setting_blind and G.GAME.blind.boss then
            card.debuff = true
            card.debuffed_by_blind = true
        end

        if context.joker_main then
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
