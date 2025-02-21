SMODS.Joker {
    key = 'coupon',
    loc_txt = {
        name = 'Coupon',
        text = { '{C:green}#1# in #2#{} chance for shop', 'Jokers to be free' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            prob = 1,
            odds = 10
        }
    },
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.prob * G.GAME.probabilities.normal, stg.odds }
        }
    end
}