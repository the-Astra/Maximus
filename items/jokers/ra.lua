SMODS.Joker {
    key = 'ra',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 17
    },
    rarity = 3,
    config = {
        extra = {
            gain = 0.1,
            Xmult = 1
        }
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" },
        reference = { "Yu-Gi-Oh!" }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.destroy_card and context.scoring_name == 'High Card' and context.cardarea == G.play and not context.blueprint then
            stg.Xmult = stg.Xmult + stg.gain * G.GAME.mxms_soil_mod
            local current_card = context.destroy_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    current_card:juice_up()
                    current_card.debuff = true
                    return true;
                end
            }))
            return {
                remove = true,
                message = localize('k_mxms_sacrifice_ex'),
                colour = G.C.RED
            }
        end

        if context.joker_main then
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
