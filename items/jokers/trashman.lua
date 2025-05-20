SMODS.Joker {
    key = 'trashman',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 15
    },
    rarity = 1,
    config = {
        extra = {
            money = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "pinkzigzagoon"
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.money }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.individual and context.cardarea == 'unscored' then
            return {
                dollars = stg.money,
                message_card = context.other_card
            }
        end
    end
}
