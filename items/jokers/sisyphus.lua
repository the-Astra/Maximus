SMODS.Joker {
    key = 'sisyphus',
    loc_txt = {
        name = 'Sisyphus',
        text = {
            'Gains {X:mult,C:white}X#1#{} Mult for',
            'every hand played',
            '{s:0.8,C:inactive}Resets at end of round',
            '{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            gain = 1,
            Xmult = 1
        }
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
                    if TalisHelper(G.GAME.chips) - TalisHelper(G.GAME.blind.chips) < TalisHelper(0) then
                        SMODS.calculate_effect(
                            {
                                message = localize('k_upgrade_ex'),
                                colour = G.C.ATTENTION,
                                func = function()
                                    stg.Xmult = stg.Xmult +
                                        stg.gain
                                end
                            }, card)
                    end
                    return true;
                end
            }))
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
