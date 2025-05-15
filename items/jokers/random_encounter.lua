SMODS.Joker {
    key = 'random_encounter',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            prob = 1,
            odds = 4,
            mult = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.prob * G.GAME.probabilities.normal, stg.odds, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.individual and context.cardarea == G.play then
            if pseudorandom(pseudoseed('rand_enc' .. G.GAME.round_resets.ante)) < stg.prob * G.GAME.probabilities.normal / stg.odds then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + stg.mult
                return {
                    message = localize('k_mxms_r_mult_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            else
                SMODS.calculate_context({ failed_prob = true, odds = stg.odds - (stg.prob * G.GAME.probabilities.normal), card =
                card })
            end
        end
    end
}
