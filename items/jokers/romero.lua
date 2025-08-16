SMODS.Joker {
    key = 'romero',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 7
    },
    soul_pos = {
        x = 3,
        y = 8
    },
    rarity = 4,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.1
        }
    },
    unlocked = false,
    unlock_condition = {
        type = '',
        extra = '',
        hidden = true
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "PsyAlola" }
    },
    blueprint_compat = true,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and stg.Xmult >= 1 then
            return {
                x_mult = stg.Xmult
            }
        end

        if context.card_added and context.card.ability.set == 'Joker' then
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "Xmult",
                scalar_value = "gain",
                message_colour = G.C.ATTENTION
            })
            return nil, true
        end
    end
}
