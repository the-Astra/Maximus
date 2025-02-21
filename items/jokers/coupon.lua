SMODS.Joker {
    key = 'coupon',
    loc_txt = {
        name = 'Coupon',
        text = { '{C:green}#1# in 10{} chance for shop', 'Jokers to be free' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            odds = 1
        }
    },
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.odds * G.GAME.probabilities.normal }
        }
    end
}