SMODS.Joker {
    key = 'spam',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 12
    },
    rarity = 1,
    config = {
        extra = {
            hands = 0
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 4,
    add_to_deck = function(self, card, from_debuff)
        local stg = card.ability.extra

        if G.hand.config.card_limit - 1 > 0 then
            stg.hands = G.hand.config.card_limit - 1
            G.hand:change_size(-stg.hands)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + stg.hands
            ease_hands_played(stg.hands)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        local stg = card.ability.extra
        if stg.hands > 0 then
            G.hand:change_size(stg.hands)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - stg.hands
            ease_hands_played(-stg.hands)
        end
    end
}
