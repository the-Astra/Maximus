SMODS.Joker {
    key = 'marco_polo',
    loc_txt = {
        name = 'Marco Polo',
        text = { '{C:mult}+#1#{} Mult if card is at secret placement', 'in Joker hand order. Given Mult is',
            '{C:red}subtracted by #2#{} for', 'each card out of place', '{C:inactive}Position changes every round{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            base_mult = 12,
            dMult = 3
        }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.base_mult, stg.dMult } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            local position = 0
            for i = 0, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    position = i
                end
            end

            local mult = stg.base_mult - (stg.dMult * (math.abs(position - G.GAME.current_round.marco_polo_pos)))

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
