SMODS.Joker {
    key = 'hypeman',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 9
    },
    rarity = 1,
    config = {
        extra = {
            dollars = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.dollars }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
    
        if context.enhancing_card then
            ease_dollars(stg.dollars)
            return {
                message = localize('$') .. stg.dollars,
                colour = G.C.GOLD,
                sound = 'mxms_hey'
            }
        end
    end,
}

local csa = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    csa(self, center, initial, delay_sprites)
    if center.set == "Enhanced" and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_context({enhancing_card = true})
    end
end
