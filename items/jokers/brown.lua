SMODS.Joker {
    key = 'brown',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            gain = 0.5,
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
        
        if context.minus_handsize and not context.blueprint then
            stg.Xmult = stg.Xmult + (math.abs(context.decrease) * stg.gain)
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {stg.Xmult}},
                func = function() SMODS.calculate_context({scaling_card = true}) end
            }
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': anerdymous', G.C.BLACK, G.C.WHITE, 1)
    end
}

local cacs = CardArea.change_size
CardArea.change_size = function(self, delta)
    cacs(self, delta)
    if delta < 0 and self == G.hand then
        SMODS.calculate_context({minus_handsize = true, decrease = delta})
    end
end