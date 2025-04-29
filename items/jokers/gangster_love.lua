SMODS.Joker {
    key = 'gangster_love',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 4,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and next(context.poker_hands['Flush']) and not context.blueprint then
            for k, v in pairs(context.scoring_hand) do
                SMODS.change_base(v, "Hearts", nil)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up(0.3, 0.4)
                        return true
                    end
                }))
            end
            return {
                message = localize('k_mxms_love_ex'),
                colour = G.C.HEARTS,
                sound = 'mxms_joker'
            }
        end
        
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': anerdymous', G.C.BLACK, G.C.WHITE, 1)
    end
}
