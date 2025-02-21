SMODS.Joker {
    key = 'jackpot',
    loc_txt = {
        name = 'Jackpot',
        text = { 'Played hands containing at least', '{C:attention}three 7\'s{}, {C:green}#1# in #3#{} chance', 'to give {C:money}$#2#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            money = 15,
            prob = 1,
            odds = 3
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.prob * G.GAME.probabilities.normal, stg.money, stg.odds }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before then
            local sevens = 0

            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() == 7 then
                    sevens = sevens + 1
                end
            end

            if sevens >= 3 then
                if pseudorandom(pseudoseed('jackpot' .. G.GAME.round_resets.ante)) < G.GAME.probabilities.normal / stg.odds then
                    ease_dollars(stg.money)
                    return {
                        message = 'Jackpot!',
                        colour = G.C.money,
                        card = card
                    }
                end
            else
                mxms_scale_pessimistics(G.GAME.probabilities.normal, stg.odds)
                return {
                    card = card,
                    message = localize('k_nope_ex'),
                    colour = G.C.SET.Tarot
                }
            end
        end
    end
}
