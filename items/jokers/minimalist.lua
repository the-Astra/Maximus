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
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
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

        if context.joker_main then
            stg.chips = stg.base_chips
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) and stg.chips > 0 then
                    stg.chips = stg.chips - stg.dChips
                end
            end

            return {
                chips = stg.chips
            }
        end
    end
}
