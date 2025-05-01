SMODS.Joker {
    key = 'unpleasant_gradient',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 3
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before and not context.blueprint and #context.scoring_hand == 4 then
            -- Code derived from Sigil
            for i = 1, #context.scoring_hand do
                if i == 1 then
                    SMODS.change_base(context.scoring_hand[i], "Clubs", nil)
                elseif i == 2 then
                    SMODS.change_base(context.scoring_hand[i], "Hearts", nil)
                elseif i == 3 then
                    SMODS.change_base(context.scoring_hand[i], "Diamonds", nil)
                elseif i == 4 then
                    SMODS.change_base(context.scoring_hand[i], "Spades", nil)
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.scoring_hand[i]:juice_up(0.3, 0.4)
                        return true
                    end
                }))
            end
            return {
                message = localize('k_mxms_unpleasant'),
                colour = G.C.PURPLE,
                card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
