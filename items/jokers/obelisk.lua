SMODS.Joker {
    key = 'obelisk',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 12
    },
    rarity = 3,
    config = {
        extra = {
            gain = 1,
            Xmult = 1,
            unscoring_cards = 0,
            unscoring_goal = 2
        }
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.Xmult, stg.unscoring_goal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.individual and context.cardarea == 'unscored' and not context.blueprint and not context.other_card.debuff then
            stg.unscoring_cards = stg.unscoring_cards + 1
            if stg.unscoring_cards < stg.unscoring_goal then
                return {
                    delay = 0.4,
                    message = stg.unscoring_cards .. '/' .. stg.unscoring_goal,
                    colour = G.C.MULT,
                    card = card
                }
            else
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "Xmult",
                    scalar_value = "gain",
                    message_key = 'k_mxms_tribute_ex',
                    message_colour = G.C.CHIPS
                })
                stg.unscoring_cards = 0
                return {
                    delay = 0.4
                }
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            stg.unscoring_cards = 0
            stg.Xmult = 1
            return {
                message = localize('k_reset'),
                colour = G.C.RED,
                card = card
            }
        end
    end
}
