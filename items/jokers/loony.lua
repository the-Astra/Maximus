SMODS.Joker {
    key = 'loony',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            mult = 10,
            type = 'High Card'
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.mult, localize(stg.type, 'poker_hands') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                mult = stg.mult
            }
        end
    end
}
