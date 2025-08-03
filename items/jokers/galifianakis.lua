SMODS.Joker {
    key = 'galifianakis',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 7
    },
    soul_pos = {
        x = 1,
        y = 8
    },
    rarity = 4,
    unlocked = false,
    unlock_condition = {
        type = '',
        extra = '',
        hidden = true
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 20,
    calculate = function(self, card, context)
        if context.before then
            if not context.scoring_hand[#context.scoring_hand].edition then
                card:juice_up(0.3, 0.4)
                context.scoring_hand[#context.scoring_hand]:set_edition({ negative = true }, true)
            end
        end
    end
}
