SMODS.Joker {
    key = 'guillotine',
    loc_txt = {
        name = 'Guillotine',
        text = { 'Scored {C:attention}Face{} or {C:attention}Ace{} cards', 'have their rank demoted',
            'to {C:attention}10{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 5
    },
    rarity = 3,
    config = {},
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
                            local other_card = context.scoring_hand[i]
                            play_sound('slice1')
                            other_card:juice_up(0.3, 0.3)
                            local suit_prefix = string.sub(other_card.base.suit, 1, 1) .. '_'
                            other_card:set_base(G.P_CARDS[suit_prefix .. 'T'])
                            return true
                        end
                    }))
                end
            end
        end
    end
}