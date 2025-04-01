SMODS.Joker {
    key = 'cheat_day',
    loc_txt = {
        name = 'Cheat Day',
        text = { 
            '{C:horoscope}Horoscope{} cards do not', 
            'get destroyed after failing' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 11
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 4,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        
        if context.failed_horoscope then
            SMODS.calculate_effect({ message = "Saved!", colour = G.C.HOROSCOPE, sound = 'tarot1' }, card)
        end

    end
}
