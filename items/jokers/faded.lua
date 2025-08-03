SMODS.Joker {
    key = 'faded',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 1
    },
    rarity = 2,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 7,
    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['Flush']) then
            local suit_check = { Diamonds = false, Spades = false, Clubs = false, Hearts = false }

            for k, v in pairs(context.scoring_hand) do
                if not SMODS.has_no_suit(v) or not SMODS.has_any_suit(v) then
                    suit_check[v.base.suit] = true
                end
            end

            for k, v in pairs(suit_check) do
                if not v then
                    return
                end
            end

            check_for_unlock({ type = 'flushaholic' })
        end
    end,
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
