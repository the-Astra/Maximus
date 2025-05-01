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

            local mult = stg.base_mult - (stg.dMult * (math.abs(position - G.GAME.current_round.marco_polo_pos)))

            if mult < 0 then
                mult = 0
            end

            return {
                mult = mult
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
