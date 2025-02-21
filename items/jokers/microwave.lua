SMODS.Joker {
    key = 'microwave',
    loc_txt = {
        name = 'Microwave',
        text = { '{C:red}Food{} Jokers are', '{C:attention}retriggered' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 0
    },
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        -- Thank you to theonegoodali from the Balatro Discord for helping me with this conditional
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.ability then
            for i = 1, #food_jokers do
                if context.other_card.config.center.key == food_jokers[i].key and food_jokers[i].name ~= 'Leftovers' then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            end
        end
    end
}
