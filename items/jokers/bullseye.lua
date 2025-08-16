SMODS.Joker {
    key = 'bullseye',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0,
            base_gain = 100
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local gain = stg.base_gain * G.GAME.round
        if gain < stg.base_gain then
            gain = stg.base_gain
        end
        return {
            vars = { gain, stg.chips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.chips > 0 then
            return {
                chips = stg.chips
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and
            to_big(G.GAME.blind.chips) == to_big(G.GAME.chips) then
            stg.temp_gain = stg.base_gain * G.GAME.round
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "chips",
                scalar_value = "temp_gain",
                message_colour = G.C.CHIPS
            })
            stg.temp_gain = nil
            return nil, true
        end
    end
}
