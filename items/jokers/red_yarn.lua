SMODS.Joker {
    key = 'red_yarn',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 19
    },
    rarity = 1,
    config = {
        extra = {
            gain = 5
        }
    },
    attributes = {
        'conspiracy',
        'mult'
    },
    mxms_credits = {
        art = { "Inky" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.conspiracy and G.GAME.consumeable_usage_total.conspiracy * stg.gain or 0 }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.conspiracy > 0 then
            return {
                mult = G.GAME.consumeable_usage_total.conspiracy * stg.gain
            }
        end

        if not context.blueprint and context.using_consumeable and context.consumeable.ability.set == "Conspiracy" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_mult', vars = { G.GAME.consumeable_usage_total.conspiracy * stg.gain } } },
                        card)
                    return true
                end
            }))
            return nil, true
        end
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
