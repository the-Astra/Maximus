SMODS.Joker {
    key = 'breadsticks',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            d_requirement = 2,
            d_tally = 0,
            chips = 0,
            dChips = 25
        }
    },
    blueprint_compat = false,
    cost = 4,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.d_requirement, stg.chips, stg.dChips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.discard and not context.blueprint and not context.other_card.debuff then
            stg.d_tally = stg.d_tally + 1
            if stg.d_tally < stg.d_requirement then
                return {
                    delay = 0.2,
                    message = stg.d_tally .. '/' .. stg.d_requirement,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                stg.chips = stg.chips + stg.dChips * G.GAME.soil_mod
                stg.d_tally = 0
                return {
                    delay = 0.2,
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card,
                    func = function() SMODS.calculate_context({ scaling_card = true }) end
                }
            end
        end

        if context.joker_main and stg.chips > 0 then
            return {
                chips = stg.chips
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            stg.d_tally = 0
            stg.chips = 0
            stg.d_requirement = stg.d_requirement + 1
            return {
                message = localize('k_mxms_more_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
