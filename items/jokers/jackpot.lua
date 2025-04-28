SMODS.Joker {
    key = 'jackpot',
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
                    SMODS.calculate_effect({ message = localize('k_mxms_jackpot_ex'), colour = G.C.MONEY },card)
                    return {
                        dollars = stg.money,
                        card = card
                    }
                end
            else
                SMODS.calculate_context({failed_prob = true, odds = stg.odds - G.GAME.probabilities.normal})
                return {
                    card = card,
                    message = localize('k_nope_ex'),
                    colour = G.C.SET.Tarot
                }
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
