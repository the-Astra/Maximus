SMODS.Joker {
    key = 'occam',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 9
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.hand and G.hand.config.highlighted_limit or 5) + 1 } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for k, v in pairs(context.full_hand) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true;
                    end
                }))
                SMODS.calculate_effect({ message = '-X1', colour = G.C.MULT }, card)
            end
        end

        if context.joker_main and #context.full_hand < G.hand.config.highlighted_limit then
            return {
                x_mult = G.hand.config.highlighted_limit - #context.full_hand + 1
            }
        end

        if context.after then
            return {
                message = localize('k_reset')
            }
        end
    end
}
