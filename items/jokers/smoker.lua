SMODS.Joker {
    key = 'smoker',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 11
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            return {
                chip_mod = stg.chips,
                message = '+' .. stg.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.scoring_name == 'High Card' and context.individual and context.cardarea == G.play then
            local chip_sum
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                chip_sum = context.other_card.ability.bonus + (context.other_card.ability.perma_bonus or 0)
            else
                chip_sum = context.other_card.base.nominal + (context.other_card.ability.perma_bonus or 0)
            end
            stg.chips = stg.chips + chip_sum
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card,
                func = function() SMODS.calculate_context({scaling_card = true}) end
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': anerdymous', G.C.BLACK, G.C.WHITE, 1)
    end
}
