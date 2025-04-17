SMODS.Joker {
    key = 'bullseye',
    loc_txt = {
        name = 'Bullseye',
        text = { 
            'If blind\'s {C:chips}Chip {C:attention}requirement', 
            'is met {C:attention}exactly{}, this joker',
            'gains {C:chips}+#1#{} Chips', 
            '{s:0.8,C:inactive}Gain is equal to 100 x Round', 
            '{C:inactive}(Currently: {C:chips}+#2# {C:inactive}Chips)' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            chips = 0,
            base_gain = 100
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local gain = stg.base_gain * G.GAME.round
        if gain < stg.base_gain then
            gain = stg.base_gain
        end
        return {
            vars = { gain, stg.chips }
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

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and
            to_big(G.GAME.blind.chips) == to_big(G.GAME.chips) then
            stg.chips = stg.chips + stg.base_gain * G.GAME.round
            SMODS.calculate_context({scaling_card = true})
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}
