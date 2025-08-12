SMODS.Challenge {
    key = 'coexist',
    rules = {
        custom = {
            { id = 'mxms_coexist' },
            { id = 'mxms_coexist2' },
        }
    },
    jokers = {
        { id = 'j_mxms_zombie' },
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if (context.selling_card and context.card.config.center.key == 'j_mxms_zombie')
            or (context.card_added and context.card.config.center.key == 'j_mxms_zombie')
            or context.mxms_joker_ability_change then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local zombies = 0
                    for k, v in pairs(G.jokers.cards) do
                        if v.config.center.key == 'j_mxms_zombie' then
                            zombies = zombies + 1
                        end
                    end
                    if context.selling_card then zombies = zombies - 1 end
                    if zombies <= 0 or zombies == G.jokers.config.card_limit then
                        Maximus.force_game_over()
                    end
                    return true;
                end
            }))
        end
    end
}

local csa = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    csa(self, center, initial, delay_sprites)
    if center.set == "Joker" and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_context({ mxms_joker_ability_change = true })
    end
end
