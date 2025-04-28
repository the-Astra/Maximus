SMODS.Joker {
    key = 'celestial_deity',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 12
    },
    rarity = 2,
    config = {
        extra = {
            extra_levels = 1
        }
    },
    blueprint_compat = false,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.extra_levels }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
       local stg = card.ability.extra
    
       G.GAME.base_planet_levels = G.GAME.base_planet_levels + stg.extra_levels
    end,
    remove_from_deck = function(self, card, from_debuff)
       local stg = card.ability.extra
    
       G.GAME.base_planet_levels = G.GAME.base_planet_levels - stg.extra_levels
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
