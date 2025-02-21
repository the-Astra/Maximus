SMODS.Joker {
    key = 'schrodinger',
    loc_txt = {
        name = 'Schrodinger\'s Cat',
        text = { '{C:green}50/50 chance{} for each joker', 'to be retriggered or', 'not trigger at all ' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 10
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.ability then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}
