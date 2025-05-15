SMODS.Joker {
    key = 'ra',
    atlas = 'Placeholder',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            gain = 0.1,
            Xmult = 1
        }
    },
    credit = {
        art = "anerdymous",
        code = "theAstra",
        concept = "anerdymous"
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

        if context.after and context.scoring_name == 'High Card' and not context.blueprint then
            for k, v in pairs(context.scoring_hand) do
                stg.Xmult = stg.Xmult + stg.gain * G.GAME.soil_mod
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:start_dissolve()
                        return true;
                    end
                }))
                SMODS.calculate_effect({ message = localize('k_mxms_sacrifice_ex') }, card)
            end
        end

        if context.joker_main then
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
