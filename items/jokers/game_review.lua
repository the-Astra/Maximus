SMODS.Joker {
    key = 'review',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 9
    },
    rarity = 2,
    config = {
        extra = {
            reps = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 6 or
                context.other_card:get_id() == 7 or
                context.other_card:get_id() == 8 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 10 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = stg.reps,
                    card = card
                }
            end
        end
    end
}
