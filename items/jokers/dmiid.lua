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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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
                    SMODS.scale_card(card, {
                        ref_table = stg,
                        ref_value = "Xmult",
                        scalar_value = "gain",
                        no_message = true
                    })
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
                    return nil, true
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

SMODS.JimboQuip {
    key = 'wq_dmiid',
    type = 'win',
    extra = { center = 'j_mxms_dmiid' }
}