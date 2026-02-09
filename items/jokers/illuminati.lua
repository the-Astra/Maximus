SMODS.Joker {
    key = 'illuminati',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 18
    },
    rarity = 2,
    config = {
        extra = {
            cards = 1
        }
    },
    mxms_credits = {
        art = { "GhostSalt" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.cards }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.end_of_round and not context.individual and not context.repetition and not context.game_over then
            for i = 1, stg.cards do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({set='Conspiracy'})
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true;
                        end
                    }))
                end
            end
        end
    end
}
