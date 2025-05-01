SMODS.Joker {
    key = 'honorable',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            mult = 0,
            gain = 10
        }
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

        if context.judgement_used and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.card:start_dissolve()
                    return true;
                end
            }))
            stg.mult = stg.mult + stg.gain * G.GAME.soil_mod
            return {
                message = localize('k_upgrade_ex')
            }
        end

        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
