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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
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

SMODS.JimboQuip {
    key = 'lq_trashman',
    type = 'loss',
    extra = { center = 'j_mxms_trashman' }
}
