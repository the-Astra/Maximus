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
        if (context.selling_card and context.card.config.center_key == 'j_mxms_zombie')
            or (context.card_added and context.card.config.center_key == 'j_mxms_zombie')
            or (context.setting_ability and context.new == 'j_mxms_zombie') then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local zombies = 0
                    for k, v in pairs(G.jokers.cards) do
                        if v.config.center_key == 'j_mxms_zombie' then
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
