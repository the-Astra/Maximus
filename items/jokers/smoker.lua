SMODS.Joker {
    key = 'smoker',
    loc_txt = {
        name = 'Smoker',
        text = { 
            'If played hand is a {C:attention}High Card{},', 
            'gains {C:chips}chips{} equal to each scoring', 
            'card\'s {C:chips}chip{} value', 
            '{C:inactive}(Currently: {C:chips}+#1# {C:inactive}Chips)' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 11
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            return {
                chip_mod = stg.chips,
                message = '+' .. stg.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.scoring_name == 'High Card' and context.individual and context.cardarea == G.play then
            local chip_sum
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                chip_sum = context.other_card.ability.bonus + (context.other_card.ability.perma_bonus or 0)
            else
                chip_sum = context.other_card.base.nominal + (context.other_card.ability.perma_bonus or 0)
            end
            stg.chips = stg.chips + chip_sum
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
        
    end
}
