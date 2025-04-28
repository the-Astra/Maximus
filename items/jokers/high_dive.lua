SMODS.Joker {
    key = 'high_dive',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 10
    },
    rarity = 2,
    config = {
        extra = 1
    },
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.repetition and context.cardarea == G.play and context.scoring_name == "High Card" then
            return {
                message = localize('k_again_ex'),
                repetitions = stg,
                card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
    end
}
