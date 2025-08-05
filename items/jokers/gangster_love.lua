SMODS.Joker {
    key = 'gangster_love',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 17
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    rarity = 2,
    blueprint_compat = false,
    cost = 4,
    calculate = function(self, card, context)
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
    end
}
