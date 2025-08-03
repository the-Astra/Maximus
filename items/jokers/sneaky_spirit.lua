SMODS.Joker {
    key = 'sneaky_spirit',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            Xmult = 2,
            discard_goal = 7,
            discards = 0
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.discard_goal, stg.discards }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.discard and not context.blueprint then
            stg.discards = stg.discards + 1
            if stg.discards > stg.discard_goal then
                stg.discards = 1
                SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.RED, sound = 'mxms_spirit_miss' },
                    card)
            end
            return {
                message = stg.discards .. '/' .. stg.discard_goal,
                sound = 'mxms_spirit_beh',
            }
        end

        if context.joker_main and stg.discards == stg.discard_goal then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('mxms_spirit_ough')
                    play_sound('mxms_spirit_pow')
                    return true
                end
            }))
            return {
                x_mult = stg.Xmult,
                sound = nil,
                func = function()
                    if not context.blueprint then
                        SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.ATTENTION }, card)
                        stg.discards = 0
                    end
                end
            }
        end
    end
}
