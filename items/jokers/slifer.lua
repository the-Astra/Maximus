SMODS.Joker {
    key = 'slifer',
    loc_txt = {
        name = 'Slifer the Sky Dragon',
        text = { 'Gives {X:mult,C:white}Xmult{} equal to the number', 'of cards {C:attention}held{} in your hand' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 10
    },
    rarity = 3,
    config = {
        extra = {
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and #G.hand.cards > 0 then
            return {
                Xmult_mod = #G.hand.cards,
                message = 'x' .. #G.hand.cards,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}
