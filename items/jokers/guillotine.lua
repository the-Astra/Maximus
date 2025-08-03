SMODS.Joker {
    key = 'guillotine',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 5
    },
    rarity = 3,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 9,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() > 10 and not context.scoring_hand[i].debuff then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.50,
                        func = function()
                            play_sound('slice1')
                            SMODS.change_base(context.scoring_hand[i], nil, '10')
                            context.scoring_hand[i]:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
            end
        end
    end
}
