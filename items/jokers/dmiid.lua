SMODS.Joker {
    key = 'dmiid',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 5
    },
    blueprint_compat = false,
    cost = 7,
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.25
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].seal then
                    local other_card = context.scoring_hand[i]
                    other_card:set_seal(nil, nil, true)
                    stg.Xmult = stg.Xmult + stg.gain * G.GAME.mxms_soil_mod
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.50,
                        func = function()
                            play_sound('card1')
                            card:juice_up(0.3, 0.3)
                            other_card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                    SMODS.calculate_context({ mxms_scaling_card = true })
                end
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if v.seal then
                return true
            end
        end

        return false
    end
}
