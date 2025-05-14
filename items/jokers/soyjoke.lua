SMODS.Joker {
    key = 'soyjoke',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 2
    },
    rarity = 2,
    config = {
        extra = {
            gain = 0.25
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { G.GAME.soy_mod * stg.gain + 1, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and G.GAME.soy_mod >= 1 then
            return {
                x_mult = G.GAME.soy_mod * stg.gain + 1
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}

local catd = Card.add_to_deck
Card.add_to_deck = function(self, from_debuff)
    catd(self, from_debuff)
    if self.ability.set == 'Joker' then
    G.E_MANAGER:add_event(Event({func = function()
        for k, v in pairs(G.GAME.purchased_jokers) do
            if v == self.ability.name then
                G.GAME.soy_mod = G.GAME.soy_mod + 1
                local soyjokes = SMODS.find_card('j_mxms_soyjoke')
                if next(soyjokes) then
                    for i = 1, #soyjokes do
                        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.ATTENTION }, soyjokes[i])
                        SMODS.calculate_context({scaling_card = true})
                    end
                end
                return true
            end
        end
        G.GAME.purchased_jokers[#G.GAME.purchased_jokers + 1] = self.ability.name
    return true end }))
end
end