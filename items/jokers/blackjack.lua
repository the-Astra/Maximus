SMODS.Joker {
    key = 'blackjack',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 16
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
            gain_norm = 0.1,
            gain_best = 1
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
            vars = { stg.gain_norm, stg.gain_best, stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and not context.blueprint then
            local hand_value = 0
            for k, v in pairs(context.scoring_hand) do
                local card_value = v:get_id()
                if card_value > 0 then
                    if card_value > 10 then
                        if v:is_face() then
                            card_value = 10
                        else
                            card_value = 11
                        end
                    end
                    hand_value = hand_value + card_value
                end
            end

            if hand_value > 21 and stg.Xmult > 1 then
                stg.Xmult = 1
                return {
                    message = localize('k_mxms_bust_ex'),
                    colour = G.C.RED
                }
            elseif hand_value == 21 then
                stg.Xmult = stg.Xmult + stg.gain_best
                return {
                    message = localize('k_mxms_blackjack_ex'),
                    colour = G.C.GREEN
                }
            else
                stg.Xmult = stg.Xmult + stg.gain_norm
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
