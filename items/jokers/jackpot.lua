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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local prob, odds = SMODS.get_probability_vars(card, stg.prob, stg.odds, 'jackpot')
        return {
            vars = { prob, odds, stg.money}
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
                if SMODS.pseudorandom_probability(card, 'jackpot', stg.prob, stg.odds) then
                    SMODS.calculate_effect({ message = localize('k_mxms_jackpot_ex'), colour = G.C.MONEY },
                        context.blueprint_card or card)
                    return {
                        dollars = stg.money,
                        card = card
                    }
                else
                    return {
                        card = card,
                        message = localize('k_nope_ex'),
                        colour = G.C.SET.Tarot
                    }
                end
            end
        end
    end
}
