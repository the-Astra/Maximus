SMODS.Joker {
    key = 'random_encounter',
    loc_txt = {
        name = 'Random Encounter',
        text = { '{C:green}#1# in #2#{} chance of', 'scored playing cards', 'gaining permanent {C:mult}+#3#{} Bonus Mult' }
    },
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
                context.other_card.ability.mxms_mult_perma_bonus = context.other_card.ability.mxms_mult_perma_bonus or 0
                context.other_card.ability.mxms_mult_perma_bonus = context.other_card.ability.mxms_mult_perma_bonus +
                    stg.mult
                return {
                    message = 'A random mult appears!',
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}

-- Get Chip Mult hook for perma mult
local cgcm = Card.get_chip_mult
function Card.get_chip_mult(self)
    local ret = cgcm(self)
    if not self.debuff and not (self.ability.set == "Joker") then
        if self.ability.mxms_mult_perma_bonus then
            ret = ret + self.ability.mxms_mult_perma_bonus
        end
    end
    return ret
end
