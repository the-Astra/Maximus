SMODS.Joker {
    key = 'jackpot',
    loc_txt = {
        name = 'Jackpot',
        text = { 'Played hands containing at least', '{C:attention}three 7\'s{}, {C:green}#1# in 3{} chance', 'to give {C:money}$#2#' }
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
            odds = 3
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { G.GAME.probabilities.normal, center.ability.extra.money }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local sevens = 0

            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() == 7 then
                    sevens = sevens + 1
                end
            end

            if sevens >= 3 then
                if pseudorandom(pseudoseed('jackpot' .. G.GAME.round_resets.ante)) < G.GAME.probabilities.normal / card.ability.extra.odds then
                    ease_dollars(card.ability.extra.money)
                    return {
                        message = 'Jackpot!',
                        colour = G.C.money,
                        card = card
                    }
                end
            else
                mxms_scale_pessimistics(G.GAME.probabilities.normal, card.ability.extra.odds)
                return {
                    card = card,
                    message = localize('k_nope_ex'),
                    colour = G.C.SET.Tarot
                }
            end
        end
    end
}