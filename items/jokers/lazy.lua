SMODS.Joker {
    key = 'lazy',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 4
    },
    rarity = 1,
    config = {
        chips = 40,
        type = 'High Card'
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability
        return {
            vars = { stg.chips, stg.type }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                chips = stg.chips
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
