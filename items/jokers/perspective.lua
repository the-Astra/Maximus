SMODS.Joker {
    key = 'perspective',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 0
    },
    rarity = 1,
    config = {},
    blueprint_compat = false,
    cost = 3,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}

-- Change Full House to not interfere with Perspective
SMODS.PokerHand:take_ownership('Full House', {
        evaluate = function(parts, hand)
            if #parts._3 < 1 or #parts._2 < 2 or #hand < 5 then return {} end
            return parts._all_pairs
        end
    },
    true)
