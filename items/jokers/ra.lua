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
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': anerdymous', G.C.BLACK, G.C.WHITE, 1)
    end
}
