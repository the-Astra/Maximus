SMODS.Joker {
    key = 'space_cowboy',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    credit = {
        art = "anerdymous",
        code = "theAstra",
        concept = "anerdymous"
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.end_of_round and not context.individual and not context.repetition
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({ set = 'Planet' })
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                    return true;
                end
            }))
            return {
                message = localize('k_plus_planet'),
                colour = G.C.SECONDARY_SET.Planet,
                sound = 'mxms_joker'
            }
        end
    end
}
