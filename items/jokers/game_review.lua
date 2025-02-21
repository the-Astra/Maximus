SMODS.Joker {
    key = 'review',
    loc_txt = {
        name = 'Game Review',
        text = { 'Retrigger each played', '{C:attention}6{}, {C:attention}7{}, {C:attention}8{}, {C:attention}9{}, or {C:attention}10' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 9
    },
    rarity = 2,
    config = {
        extra = 1
    },
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 6 or
                context.other_card:get_id() == 7 or
                context.other_card:get_id() == 8 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 10 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
    end
}
