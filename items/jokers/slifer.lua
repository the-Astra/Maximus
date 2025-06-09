SMODS.Joker {
    key = 'slifer',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 10
    },
    rarity = 3,
    config = {
        extra = {
        }
    },
    credit = {
        art = "anerdymous",
        code = "theAstra",
        concept = "anerdymous"
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and #G.hand.cards > 0 then
            return {
                x_mult = #G.hand.cards
            }
        end
    end
}
