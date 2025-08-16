SMODS.Joker {
    key = 'sisyphus',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 14
    },
    rarity = 3,
    config = {
        extra = {
            gain = 1,
            Xmult = 1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.after and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if to_big(G.GAME.chips) - to_big(G.GAME.blind.chips) < to_big(0) then
                        SMODS.scale_card(card {
                            ref_table = stg,
                            ref_value = "Xmult",
                            scalar_value = "gain",
                            message_colour = G.C.ATTENTION
                        })
                    end
                    return true;
                end
            }))
            return nil, true
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end

        if context.end_of_round and not context.individual and not context.repetition then
            stg.Xmult = 1
            return {
                message = localize('k_reset'),
                colour = G.C.FILTER
            }
        end
    end
}
