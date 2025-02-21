SMODS.Joker {
    key = 'breadsticks',
    loc_txt = {
        name = 'Endless Breadsticks',
        text = { 'Gains {C:chips}+25{} Chips every {C:attention}#1#{} cards', 'discarded this round. Discard requirement', 'increases by {C:attention}1{} and resets {C:chips}Chips{}', 'each round', '{C:inactive}Currently: {C:chips}+#2#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            d_requirement = 2,
            d_tally = 0,
            chips = 0
        }
    },
    blueprint_compat = false,
    cost = 4,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.d_requirement, center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not context.other_card.debuff then
            card.ability.extra.d_tally = card.ability.extra.d_tally + 1
            if card.ability.extra.d_tally < card.ability.extra.d_requirement then
                return {
                    delay = 0.2,
                    message = card.ability.extra.d_tally .. '/' .. card.ability.extra.d_requirement,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                card.ability.extra.chips = card.ability.extra.chips + 25 * G.GAME.soil_mod
                card.ability.extra.d_tally = 0
                return {
                    delay = 0.2,
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end

        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.d_tally = 0
            card.ability.extra.chips = 0
            card.ability.extra.d_requirement = card.ability.extra.d_requirement + 1
            return {
                message = 'More Please!',
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}