SMODS.Joker {
    key = 'space_race',
    loc_txt = {
        name = 'Space Race',
        text = { 'If played hand is not the highest', 'level hand, upgrade hand by one level',
            '{C:inactive}Hands tied for highest do not upgrade{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 5
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then

            if context.scoring_name ~= G.GAME.current_round.most_played_poker_hand 
                or G.GAME.hands[context.scoring_name].played ~= G.GAME.hands[G.GAME.current_round.most_played_poker_hand].played then
                return {
                    card = card,
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}
