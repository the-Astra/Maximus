SMODS.Joker {
    key = 'stone_thrower',
    loc_txt = {
        name = 'Stone Thrower',
        text = { 'Gains {C:chips}+30{} Chips for every', 'scored {C:attention}glass card{}', 'Glass cards are {C:attention}guaranteed to break{}', '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 9
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = false,
    enhancement_gate = 'm_glass',
    cost = 3,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {
            vars = { center.ability.extra.chips }
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

        if context.individual and context.cardarea == G.play and context.other_card.config.center == G.P_CENTERS.m_glass then
            card.ability.extra.chips = card.ability.extra.chips + 30 * G.GAME.soil_mod
            SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.CHIPS }, card)
        end
    end
}