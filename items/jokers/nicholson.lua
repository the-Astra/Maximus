SMODS.Joker {
    key = 'nicholson',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 7
    },
    soul_pos = {
        x = 4,
        y = 8
    },
    config = {
        extra = 1
    },
    rarity = 4,
    unlocked = false,
    unlock_condition = {
        type = '', 
        extra = '', 
        hidden = true
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "9mmPeter"
    },
    blueprint_compat = true,
    cost = 20,
    calculate = function(self, card, context)
        if context.other_card and context.other_card.edition and
            (context.repetition and context.cardarea == G.play or
                context.retrigger_joker_check and not context.retrigger_joker) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra,
                card = card
            }
        end
    end
}
