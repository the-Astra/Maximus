SMODS.Joker {
    key = 'marco_polo',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            base_mult = 12,
            dMult = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.base_mult, stg.dMult } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            local position = 0
            for i = 0, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    position = i
                end
            end

            local mult = stg.base_mult - (stg.dMult * (math.abs(position - G.GAME.current_round.mxms_marco_polo_pos)))

            if mult < 0 then
                mult = 0
            end

            return {
                mult = mult
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_marco_polo',
    type = 'loss',
    extra = { center = 'j_mxms_marco_polo' }
}