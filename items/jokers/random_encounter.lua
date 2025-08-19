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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local prob, odds = SMODS.get_probability_vars(card, stg.prob, stg.odds, 'rand_enc')
        return {
            vars = { prob, odds, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'rand_enc', stg.prob, stg.odds) then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + stg.mult
                return {
                    message = localize('k_mxms_r_mult_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}

SMODS.JimboQuip {
    key = 'wq_random_encounter',
    type = 'win',
    extra = { center = 'j_mxms_random_encounter' }
}
