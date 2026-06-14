SMODS.Joker {
    key = 'apophenia',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 19
    },
    rarity = 3,
    attributes = {
        'conspiracy',
        'generation',
        'hand_type'
    },
    blueprint_compat = true,
    cost = 5,
    mxms_credits = {
        art = { "Meta" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and next(context.poker_hands["Straight"]) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({ set = 'Conspiracy', edition = 'e_negative' })
                    card:juice_up()
                    return true;
                end
            }))
        end
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
