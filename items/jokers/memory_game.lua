SMODS.Joker {
    key = 'memory_game',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 9
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Pair" and not context.blueprint then
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)

            delay(0.2)

            for i = 1, 2 do
                local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                context.scoring_hand[i]:flip();
                play_sound('card1', percent);
                context.scoring_hand[i]:juice_up(0.3, 0.3);
            end

            delay(0.2)

            copy_card(context.scoring_hand[2], context.scoring_hand[1])

            for i = 1, 2 do
                local percent = 0.85 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        context.scoring_hand[i]:flip();
                        play_sound('card1', percent);
                        context.scoring_hand[i]:juice_up(0.3, 0.3);
                        return true
                    end
                }))
            end
            delay(0.5)
        end
    end
}
