SMODS.Joker {
    key = 'galaxy_brain',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.25,
            last_hand = nil
        }
    },
    credit = {
        art = "pinkzigzagoon",
        code = "theAstra",
        concept = "pinkzigzagoon"
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain, stg.last_hand and G.localization.misc.poker_hands[stg.last_hand] or 'None' }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and not context.blueprint then
            for k, v in pairs(G.GAME.hands) do
                if k == stg.last_hand then
                    stg.last_hand = k
                    stg.Xmult = 1
                    return {
                        message = localize('k_reset'),
                        colour = G.C.FILTER
                    }
                elseif k == context.scoring_name then
                    stg.last_hand = k
                    stg.Xmult = stg.Xmult + stg.gain * G.GAME.soil_mod
                    return {
                        message = localize('k_upgrade_ex'),
                        func = function() SMODS.calculate_context({ scaling_card = true }) end
                    }
                end
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    set_ability = function(self, card, initial, delay)
        local stg = card.ability.extra

        stg.last_hand = G.GAME.last_hand_played or 'None'
    end
}
