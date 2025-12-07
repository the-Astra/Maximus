SMODS.Joker {
    key = 'context',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 18
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0,
            mult = 0
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            SMODS.calculate_effect({ chips = stg.chips }, context.blueprint_card or card)
            SMODS.calculate_effect({ mult = stg.mult }, context.blueprint_card or card)
        end

        if context.after and not context.repetition and not context.individual and not context.blueprint then
            stg.chips = stg.chips + SMODS.PokerHands[context.scoring_name].chips
            stg.mult = stg.mult + SMODS.PokerHands[context.scoring_name].mult
            return {
                message = localize('k_upgrade_ex')
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            stg.chips = 0
            stg.mult = 0
            return {
                message = localize('k_reset')
            }
        end
    end
}
