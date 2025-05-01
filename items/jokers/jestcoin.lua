SMODS.Joker {
    key = 'jestcoin',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            money = 2,
            prob = 1,
            odds = 3
        }
    },
    blueprint_compat = false,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.money, stg.prob * G.GAME.probabilities.normal, stg.odds }
        }
    end,
    calc_dollar_bonus = function(self, card)
        local stg = card.ability.extra

        if pseudorandom(pseudoseed('jestcoin' .. G.GAME.round_resets.ante)) < stg.prob * G.GAME.probabilities.normal / stg.odds then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(-G.GAME.dollars, true)
                    return true;
                end
            }))
            SMODS.calculate_effect({ message = localize('k_mxms_crashed_ex'), colour = G.C.RED }, card)
            SMODS.calculate_context({ failed_prob = true, odds = stg.odds - (stg.prob * G.GAME.probabilities.normal), card =
            card })
            stg.money = 2
            SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.ATTENTION }, card)
        else
            local cashout = stg.money
            stg.money = stg.money ^ 2
            SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.MONEY }, card)
            SMODS.calculate_context({ scaling_card = true })
            return cashout
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
