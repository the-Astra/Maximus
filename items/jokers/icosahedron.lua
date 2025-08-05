SMODS.Joker {
    key = 'icosahedron',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 13
    },
    rarity = 1,
    config = {
        extra = {
            tally = 0,
            goal = 20,
            Xmult = 0.2
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.goal, stg.Xmult, stg.tally }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.individual and context.cardarea == G.play and not context.blueprint
            and context.other_card:is_suit('Diamonds', false) and not context.repetition then
            stg.tally = stg.tally + 1
            return {
                message = stg.tally .. '/' .. stg.goal,
                colour = G.C.MULT,
                message_card = card,
                func = function()
                    if stg.tally == stg.goal then
                        context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
                        context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + stg.Xmult
                        stg.tally = 0
                        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.MULT }, card)
                    end
                end
            }
        end
    end
}
