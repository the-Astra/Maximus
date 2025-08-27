SMODS.Joker {
    key = 'werewolf',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 15
    },
    rarity = 1,
    config = {
        extra = {
            mult = 0,
            gain = 5
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS['c_moon']
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and context.consumeable.config.center_key == 'c_moon' and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "mult",
                scalar_value = "gain",
                message_key = 'a_mult',
                message_colour = G.C.MULT
            })
            return nil, true
        end

        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult
            }
        end
    end
}
