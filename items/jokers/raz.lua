SMODS.Joker {
    key = 'raz',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 7
    },
    soul_pos = {
        x = 8,
        y = 8
    },
    rarity = 4,
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 20,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.individual and context.cardarea == 'unscored' and (next(context.poker_hands['Straight']) or next(context.poker_hands['Flush'])) then
            return {
                level_up = true,
                message = localize('k_level_up_ex'),
                message_card = card
            }
        end
    end
}

local sff = SMODS.four_fingers
function SMODS.four_fingers(...)
    local ret = sff(...)
    if next(SMODS.find_card('j_mxms_raz')) then
        ret = 3
    end
    return ret
end