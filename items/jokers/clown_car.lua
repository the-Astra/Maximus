SMODS.Joker {
    key = 'clown_car',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 3
    },
    rarity = 2,
    config = {
        extra = {
            mult = 0,
            gain = 2
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.mult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult,
            }
        end

        if context.card_added and context.card.ability.set == 'Joker' then
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "mult",
                scalar_value = "gain",
                message_colour = G.C.ATTENTION
            })
            return nil, true
        end
    end
}
