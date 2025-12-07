SMODS.Joker {
    key = 'semisolid',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 18
    },
    rarity = 1,
    config = {
        extra = {
            activated = false,
            cards_to_draw = 0
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.mxms_pre_draw and not stg.activated and not context.blueprint then
            local cards = {}
            for i, v in ipairs(G.deck.cards) do
                if v:get_id() == 8 then
                    table.insert(cards, G.deck.cards[i])
                    table.remove(G.deck.cards, i)
                    stg.activated = true
                end
            end
            for i, v in ipairs(cards) do
                table.insert(G.deck.cards, #G.deck.cards + 1, v)
            end
            stg.cards_to_draw = #cards
        end

        if context.drawing_cards and stg.cards_to_draw > G.hand.config.card_limit then
            return {
                cards_to_draw = stg.cards_to_draw,
                func = function()
                    stg.cards_to_draw = 0
                end
            }
        end

        if context.end_of_round and stg.activated and not context.blueprint then
            stg.activated = false
        end
    end
}
