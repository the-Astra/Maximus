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
    config = {
        extra = {
            triggered = false
        }
    },
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and #context.scoring_hand == 4 then
            -- Code derived from Sigil
            for i = 1, #context.scoring_hand do
                local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        local other_card = context.scoring_hand[i]
                        other_card:flip()
                        play_sound('card1', percent)
                        other_card:juice_up(0.3, 0.3)
                        local rank_suffix = other_card.base.id < 10 and tostring(other_card.base.id) or
                            other_card.base.id == 10 and 'T' or other_card.base.id == 11 and 'J' or
                            other_card.base.id == 12 and 'Q' or other_card.base.id == 13 and 'K' or
                            other_card.base.id == 14 and 'A'
                        if i == 1 then
                            other_card:set_base(G.P_CARDS['C_' .. rank_suffix])
                        elseif i == 2 then
                            other_card:set_base(G.P_CARDS['H_' .. rank_suffix])
                        elseif i == 3 then
                            other_card:set_base(G.P_CARDS['D_' .. rank_suffix])
                        elseif i == 4 then
                            other_card:set_base(G.P_CARDS['S_' .. rank_suffix])
                        end
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #context.scoring_hand do
                local percent = 0.85 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        local other_card = context.scoring_hand[i]
                        other_card:flip()
                        play_sound('tarot2', percent, 0.6)
                        other_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.5)
            card.ability.extra.triggered = true
            return {
                message = 'how Unpleasant',
                colour = G.C.PURPLE,
                card = card
            }
        end

        if context.after and card.ability.extra.triggered then
            card.ability.extra.triggered = false
        end
    end
}