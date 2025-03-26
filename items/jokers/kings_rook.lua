SMODS.Joker {
    key = 'kings_rook',
    loc_txt = {
        name = 'King\'s Rook',
        text = { 'If played hand has a', '{C:attention}scoring King{} and a {C:attention}scoring 5{},', '{C:attention}retrigger{} all {C:attention}Kings{} and {C:attention}5s{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 10
    },
    rarity = 1,
    config = {
        extra = 1
    },
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local kings = false
            local fives = false

            for k, v in pairs(context.scoring_hand) do
                if v:get_id() == 13 then
                    kings = true
                elseif v:get_id() == 5 then
                    fives = true
                end
            end

            if kings and fives and
                (context.other_card:get_id() == 13 or
                    context.other_card:get_id() == 5) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
    end
}
