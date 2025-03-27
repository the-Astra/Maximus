SMODS.Joker {
    key = 'unpleasant_gradient',
    loc_txt = {
        name = 'Unpleasant Gradient',
        text = { 'If scored hand has exactly 4 cards,', 'convert each card into {C:clubs}Clubs{},',
            '{C:hearts}Hearts{}, {C:diamonds}Diamonds{}, and {C:spades}Spades', 'respectively from left to right' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 3
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before and not context.blueprint and #context.scoring_hand == 4 then
            -- Code derived from Sigil
            for i = 1, #context.scoring_hand do
                if i == 1 then
                    SMODS.change_base(context.scoring_hand[i], "Clubs", nil)
                elseif i == 2 then
                    SMODS.change_base(context.scoring_hand[i], "Hearts", nil)
                elseif i == 3 then
                    SMODS.change_base(context.scoring_hand[i], "Diamonds", nil)
                elseif i == 4 then
                    SMODS.change_base(context.scoring_hand[i], "Spades", nil)
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.scoring_hand[i]:juice_up(0.3, 0.4)
                        return true
                    end
                }))
            end
            return {
                message = 'how Unpleasant',
                colour = G.C.PURPLE,
                card = card
            }
        end
    end
}
