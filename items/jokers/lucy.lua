SMODS.Joker {
    key = 'lucy',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 16
    },
    rarity = 1,
    config = {
        extra = {
            prob_gain = 1,
            odds = 5,
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        return {
            vars = { stg.prob_gain * G.GAME.probabilities.normal, stg.odds }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before then
            local prob = 0

            for k, v in pairs(context.scoring_hand) do
                if v:is_suit('Diamonds') then
                    prob = prob + stg.prob_gain
                end
            end

            if SMODS.pseudorandom_probability(card, 'lucy', prob, stg.odds) then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    local planet_key
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == G.GAME.last_hand_played then
                            planet_key = v.key
                        end
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({ key = planet_key })
                            G.GAME.consumeable_buffer = 0
                            return true;
                        end
                    }))
                    return {
                        message = localize('k_plus_planet'),
                        colour = G.C.SECONDARY_SET.Planet
                    }
                end
            end
        end
    end
}
