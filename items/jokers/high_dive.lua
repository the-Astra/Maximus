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
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.modify_scoring_hand and G.GAME.last_hand_played == 'High Card' then
            return {
                add_to_hand = true
            }
        end

        if context.repetition and context.cardarea == G.play and context.scoring_name == "High Card" then
            return {
                message = localize('k_again_ex'),
                repetitions = stg,
                card = card
            }
        end
    end
}
