SMODS.Joker {
    key = 'marco_polo',
    loc_txt = {
        name = 'Marco Polo',
        text = { '{C:mult}+12{} Mult if card is at secret placement', 'in Joker hand order. Given Mult is',
            '{C:red}subtracted by 3{} for', 'each card out of place', '{C:inactive}Position changes every round{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 4
    },
    rarity = 1,
    config = {},
    blueprint_compat = true,
    cost = 3,
    calculate = function(self, card, context)
        if context.joker_main then
            local position = 0
            for i = 0, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    position = i
                end
            end

            local mult = 12 - (3 * (math.abs(position - G.GAME.current_round.marco_polo_pos)))

            if mult < 0 then
                mult = 0
            end

            return {
                mult_mod = mult,
                message = '+' .. mult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
}