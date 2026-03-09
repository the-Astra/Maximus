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
    config = {
        extra = {
            triggered = false
        }
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

        if context.setting_blind then
            local eval = function(card) return not card.ability.extra.triggered and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.before and not stg.triggered and (next(context.poker_hands['Straight']) or next(context.poker_hands['Flush'])) then
            stg.triggered = true
            for k, v in pairs(G.mxms_horoscope.cards) do
                v.config.center:succeed(v)
            end
        end

        if context.end_of_round and stg.triggered then
            stg.triggered = false
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
