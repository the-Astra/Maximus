SMODS.Joker {
    key = 'conveyor_belt',
    loc_txt = {
        name = 'Conveyor Belt',
        text = {
            'Gives {C:attention}15%{} of {C:chips}Chips{} and {C:mult}Mult{}',
            'from previous hand at',
            'beginning of the following hand',
            '{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips,','{C:mult}+#2#{C:inactive} Mult)'
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 12
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0,
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and TalisHelper(stg.chips) > TalisHelper(0) and TalisHelper(stg.mult) > TalisHelper(0) then
            SMODS.calculate_effect({ chips = stg.chips }, card)
            SMODS.calculate_effect({ mult = stg.mult }, card)
        end

        if context.after and not context.blueprint then
            stg.chips = mod_chips(hand_chips * 0.15)
            stg.mult = mod_mult(mult * 0.15)
            return {
                message = 'Pushed!',
                colour = G.C.ATTENTION
            }
        end
    end
}
