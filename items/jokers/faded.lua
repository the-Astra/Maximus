SMODS.Joker {
    key = 'faded',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 1
    },
    rarity = 2,
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = false,
    cost = 7
}

local cis = Card.is_suit
Card.is_suit = function(self, suit, bypass_debuff, flush_calc)
    if not SMODS.has_no_suit(self) then
        if flush_calc then
            if next(SMODS.find_card('j_mxms_faded')) and next(find_joker('Smeared Joker')) and vanilla_suit_check(self, suit) then
                return true
            end
            if next(SMODS.find_card('j_mxms_faded')) and faded_check(self, suit) then
                return true
            end
        else
            if next(SMODS.find_card('j_mxms_faded')) and next(find_joker('Smeared Joker')) and vanilla_suit_check(self, suit) then
                return true
            end
            if next(SMODS.find_card('j_mxms_faded')) and faded_check(self, suit) then
                return true
            end
        end
    end
    return cis(self, suit, bypass_debuff, flush_calc)
end

function faded_check(card, suit)
    if ((card.base.suit == 'Spades' or card.base.suit == 'Diamonds') and (suit == 'Spades' or suit == 'Diamonds')) then
        return true
    elseif (card.base.suit == 'Hearts' or card.base.suit == 'Clubs') and (suit == 'Hearts' or suit == 'Clubs') then
        return true
    end
    return false
end

function vanilla_suit_check(card, suit)
    if card.base.suit == 'Spades' or
        card.base.suit == 'Diamonds' or
        card.base.suit == 'Hearts' or
        card.base.suit == 'Clubs' then
        return true
    end
end
