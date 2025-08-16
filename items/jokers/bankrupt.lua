SMODS.Joker {
    key = 'bankrupt',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 16
    },
    rarity = 1,
    config = {
        extra = {
            gain = 10,
            mult = 0
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" },
        reference = { "Wheel of Fortune" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.pseudorandom_result and not context.result and context.identifier == 'wheel_of_fortune' and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "mult",
                scalar_value = "gain",
                message_key = "a_mult"
            })
            return nil, true
        end

        if context.joker_main then
            return {
                mult = stg.mult
            }
        end
    end
}
