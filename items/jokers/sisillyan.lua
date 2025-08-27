SMODS.Joker {
    key = 'sisillyan',
    atlas = 'Placeholder',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            Xmult = 10,
            prob = 1,
            odds = 10
        }
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, SMODS.get_probability_vars(card, stg.prob, stg.odds) }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            return {
                x_mult = stg.Xmult
            }
        end

        if context.after and not context.blueprint and SMODS.pseudorandom_probability(card, 'sisilly', stg.prob, stg.odds) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    Maximus.force_game_over()
                    return true;
                end
            }))
        end
    end
}
