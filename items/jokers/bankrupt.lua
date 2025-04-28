SMODS.Joker {
    key = 'bankrupt',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            gain = 10,
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        
        if context.failed_prob and context.card.config.center.key == 'c_wheel_of_fortune' then
            stg.mult = stg.mult + stg.gain
            return {
                message = localize{type = 'variable', key = 'a_mult', vars = {stg.mult}},
                func = function() SMODS.calculate_context({scaling_card = true}) end
            }
        end

        if context.joker_main then
            return {
                mult = stg.mult
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': anerdymous', G.C.BLACK, G.C.WHITE, 1)
    end
}
