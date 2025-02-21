SMODS.Joker {
    key = 'bullseye',
    loc_txt = {
        name = 'Bullseye',
        text = { 'If {C:attention}blind\'s{} Chip requirement', 'is met {C:attention}exactly{}, this joker',
            'gains {C:chips}+#1#{} Chips', '{C:inactive}Gain is equal to 100 x Round', '{C:inactive}Currently: {C:chips}+#2#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, center)
        local gain = 100 * G.GAME.round
        if gain < 100 then
            gain = 100
        end
        return {
            vars = { gain, center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and
            G.GAME.blind.chips == G.GAME.chips then
            card.ability.extra.chips = card:scale_value(card.ability.extra.chips, 100 * G.GAME.round)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}