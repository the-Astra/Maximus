SMODS.Joker {
    key = 'lazy',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            chips = 40,
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
            vars = { stg.chips, localize(stg.type, 'poker_hands') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                chips = stg.chips
            }
        end
    end
}
