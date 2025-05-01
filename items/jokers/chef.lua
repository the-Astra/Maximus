SMODS.Joker {
    key = 'chef',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 2
    },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({
                        set = 'Food',
                    })
                    card:juice_up(0.3, 0.4)
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    return true;
                end
            }))
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
