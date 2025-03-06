SMODS.Joker {
    key = 'nicholson',
    loc_txt = {
        name = 'Nicholson',
        text = { 'Retrigger any card', 'with an {C:attention}Edition{}' }
    },
    atlas = 'Placeholder',
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = 1
    },
    rarity = 4,
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
