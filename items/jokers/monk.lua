SMODS.Joker {
    key = 'monk',
    loc_txt = {
        name = 'Monk',
        text = { 'Gains {C:chips}+#2#{} chips for every', 'shop exited without purchase',
            '{C:inactive}Currently: {C:chips}+#1#{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            purchase_made = false,
            chips = 0,
            gain = 25
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.chips > 0 then
            return {
                chip_mod = stg.chips,
                message = '+' .. stg.chips,
                colour = G.C.MULT,
                card = card
            }
        end

        if (context.buying_card or context.open_booster or context.reroll_shop) and not context.blueprint then
            stg.purchase_made = true
        end

        if context.ending_shop and not stg.purchase_made then
            card:juice_up(0.3, 0.4)
            play_sound('tarot1')
            stg.chips = card:scale_value(stg.chips, stg.gain)
        end

        if context.setting_blind then
            stg.purchase_made = false
        end
    end
}