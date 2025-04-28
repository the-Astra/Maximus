SMODS.Joker {
    key = 'minimalist',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            chips = 90,
            base_chips = 90,
            dChips = 15
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        stg.chips = stg.base_chips
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) and stg.chips > 0 then
                    stg.chips = stg.chips - stg.dChips
                end
            end
        end

        return {
            vars = { stg.base_chips, stg.chips, stg.dChips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        stg.chips = stg.base_chips
        for k, v in pairs(G.playing_cards) do
            if next(SMODS.get_enhancements(v)) and stg.chips > 0 then
                stg.chips = stg.chips - stg.dChips
            end
        end

        if context.joker_main and stg.chips > 0 then
            return {
                chips = stg.chips
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
    end
}
