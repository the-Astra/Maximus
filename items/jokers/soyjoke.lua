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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { G.GAME.mxms_soy_mod * stg.gain + 1, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.mxms_reacquire_joker and not context.blueprint then
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.ATTENTION
            }
        end

        if context.joker_main and G.GAME.mxms_soy_mod >= 1 then
            return {
                x_mult = G.GAME.mxms_soy_mod * stg.gain + 1
            }
        end
    end
}

local catd = Card.add_to_deck
Card.add_to_deck = function(self, from_debuff)
    catd(self, from_debuff)
    if self.ability.set == 'Joker' and not from_debuff then
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.GAME.mxms_purchased_jokers) do
                    if v == self.ability.name then
                        G.GAME.mxms_soy_mod = G.GAME.mxms_soy_mod + 1
                        SMODS.calculate_context({ mxms_reacquire_joker = true })
                        return true
                    end
                end
                G.GAME.mxms_purchased_jokers[#G.GAME.mxms_purchased_jokers + 1] = self.ability.name
                return true
            end
        }))
    end
end
