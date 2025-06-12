SMODS.Joker {
    key = 'honorable',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 15
    },
    rarity = 1,
    config = {
        extra = {
            mult = 0,
            gain = 10
        }
    },
    credit = {
        art = "pinkzigzagoon",
        code = "theAstra",
        concept = "anerdymous"
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_judgement
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.mxms_judgement_used and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.card:start_dissolve()
                    return true;
                end
            }))
            stg.mult = stg.mult + stg.gain * G.GAME.mxms_soil_mod
            return {
                message = localize('k_upgrade_ex')
            }
        end

        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult
            }
        end
    end
}
