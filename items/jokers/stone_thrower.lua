SMODS.Joker {
    key = 'stone_thrower',
    loc_txt = {
        name = 'Stone Thrower',
        text = { 'Gains {C:chips}+#2#{} Chips for every', 'scored {C:attention}glass card{}', 'Glass cards are {C:attention}guaranteed to break{}', '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 9
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0,
            gain = 30
        }
    },
    blueprint_compat = false,
    enhancement_gate = 'm_glass',
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
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
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.individual and context.cardarea == G.play and context.other_card.config.center == G.P_CENTERS.m_glass then
            stg.chips = stg.chips + stg.gain  * G.GAME.soil_mod
            SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.CHIPS }, card)
        end
    end
}