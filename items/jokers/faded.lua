SMODS.Joker {
    key = 'faded',
    loc_txt = {
        name = 'Faded Joker',
        text = { 
            '{C:diamonds}Diamonds{} and {C:spades}Spades{}', 
            'count as the same suit,',
            '{C:hearts}Hearts{} and {C:clubs}Clubs{}', 
            'count as the same suit' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 1
    },
    rarity = 2,
    config = {},
    blueprint_compat = false,
    cost = 7,
}

function faded_check(card, suit)
    if ((card.base.suit == 'Spades' or card.base.suit == 'Diamonds') and (suit == 'Spades' or suit == 'Diamonds')) then
        return true
    elseif (card.base.suit == 'Hearts' or card.base.suit == 'Clubs') and (suit == 'Hearts' or suit == 'Clubs') then
        return true
    end
    return false
end
