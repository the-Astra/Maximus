SMODS.Joker {
    key = 'hypeman',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 9
    },
    rarity = 1,
    config = {
        extra = {
            dollars = 1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.dollars }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.setting_ability and G.P_CENTER_POOLS.Enhanced[context.new] then
            ease_dollars(stg.dollars)
            return {
                message = localize('$') .. stg.dollars,
                colour = G.C.GOLD,
                sound = 'mxms_hey'
            }
        end
    end,
}
