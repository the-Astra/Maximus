SMODS.Joker {
    key = 'high_dive',
    loc_txt = {
        name = 'High Dive',
        text = { 'If played hand is a {C:attention}High Card,', '{C:attention}score{} and {C:attention}retrigger{}', 'every played card' }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 1
    },
    rarity = 2,
    config = {
        extra = 1
    },
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.repetition and context.cardarea == G.play and context.scoring_name == "High Card" then
            return {
                message = localize('k_again_ex'),
                repetitions = stg,
                card = card
            }
        end
    end
}
