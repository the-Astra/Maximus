SMODS.Joker {
    key = 'hypeman',
    loc_txt = {
        name = 'Hype Man',
        text = { 'Gives {C:money}$#1#{} every', 'time a card is', '{C:attention}enhanced{}' }
    },
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
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.dollars }
        }
    end
}

local csa = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    csa(self, center, initial, delay_sprites)
    if center.set == "Enhanced" and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        local hypes = SMODS.find_card('j_mxms_hypeman')
        if next(hypes) then
            for k, v in ipairs(hypes) do
                SMODS.calculate_effect(
                    { message = '+' .. v.ability.extra.dollars, colour = G.C.MONEY, sound = 'mxms_hey' },
                    v)
                ease_dollars(v.ability.extra.dollars)
            end
        end
    end
end
