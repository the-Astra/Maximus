SMODS.Joker {
    key = 'monk',
    loc_txt = {
        name = 'Monk',
        text = { 'Gains {C:chips}+25{} chips for every', 'shop exited without purchase',
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
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.MULT,
                card = card
            }
        end

        if (context.buying_card or context.open_booster or context.reroll_shop) and not context.blueprint then
            card.ability.extra.purchase_made = true
        end

        if context.ending_shop and not card.ability.extra.purchase_made then
            card:juice_up(0.3, 0.4)
            play_sound('tarot1')
            card.ability.extra.chips = card:scale_value(card.ability.extra.chips, 25)
        end

        if context.setting_blind then
            card.ability.extra.purchase_made = false
        end
    end
}