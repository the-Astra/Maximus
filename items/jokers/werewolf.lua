SMODS.Joker {
    key = 'werewolf',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            mult = 0,
            gain = 15
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS['c_moon']
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and context.consumeable.config.center.key == 'c_moon' and not context.blueprint then
            stg.mult = stg.mult + stg.gain
            SMODS.calculate_effect(
                { message = localize { type = 'variable', key = 'a_mult', vars = { stg.mult } }, colour = G.C.MULT },
                card)
            SMODS.calculate_context({scaling_card = true})
        end

        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult
            }
        end
    end
}
