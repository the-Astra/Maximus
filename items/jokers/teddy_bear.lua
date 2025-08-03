SMODS.Joker {
    key = 'teddy_bear',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 14
    },
    rarity = 1,
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    if G.GAME.last_hand_played then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        SMODS.add_card({ key = _planet })
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)
            }))
            SMODS.calculate_effect({ message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }, context.blueprint_card or card)
        end
    end
}
