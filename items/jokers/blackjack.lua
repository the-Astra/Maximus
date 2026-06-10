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
            gain_best = 0.5
        }
    },
    attributes = {
        'xmult'
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    perishable_compat = false,
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

        -- Initial hand value
        if context.before and not context.blueprint then
            local hand_value = Maximus.calculate_blackjack_value(context.scoring_hand)

            -- Final pass to determine scaling
            if hand_value > 21 then
                -- If Xmult isn't bigger than 1, do nothing
                if stg.Xmult > 1 then 
                    stg.Xmult = 1
                    return {
                        message = localize('k_mxms_bust_ex'),
                        colour = G.C.RED
                    }
                end
            elseif hand_value == 21 then
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "Xmult",
                    scalar_value = "gain_best",
                    message_key = "k_mxms_blackjack_ex",
                    message_colour = G.C.GREEN
                })
                return nil, true
            else
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "Xmult",
                    scalar_value = "gain_norm",
                })
                return nil, true
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
