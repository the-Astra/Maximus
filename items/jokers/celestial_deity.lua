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
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "theAstra"
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
    end
}
