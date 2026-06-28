SMODS.Joker {
    key = 'grifter',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 18
    },
    rarity = 1,
    config = {
        extra = {
            gain = 10
        }
    },
    attributes = {
        'conspiracy',
        'chips'
    },
    mxms_credits = {
        art = { "GhostSalt" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local usage_total = G.GAME and G.GAME.consumeable_usage_total
        local conspiracy_count = usage_total and usage_total.conspiracy or 0
        return {
            vars = { stg.gain, conspiracy_count * stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        local usage_total = G.GAME and G.GAME.consumeable_usage_total
        local conspiracy_count = usage_total and usage_total.conspiracy or 0
        if context.joker_main and conspiracy_count > 0 then
            return {
                chips = conspiracy_count * stg.gain
            }
        end

        if not context.blueprint and context.using_consumeable and context.consumeable.ability.set == "Conspiracy" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local updated_usage_total = G.GAME and G.GAME.consumeable_usage_total
                    local updated_conspiracy_count = updated_usage_total and updated_usage_total.conspiracy or 0
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_chips', vars = { updated_conspiracy_count * stg.gain } } },
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
