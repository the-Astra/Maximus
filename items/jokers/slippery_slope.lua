SMODS.Joker {
    key = 'slippery_slope',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 11
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            for k, v in pairs(context.poker_hands) do
                if k ~= context.scoring_name and next(context.poker_hands[k]) then
                    SMODS.calculate_effect({ message = G.localization.misc.poker_hands[k], colour = G.C.ATTENTION }, card)
                    SMODS.calculate_effect(
                        { message = '+' .. tostring(G.GAME.hands[k].chips), chip_mod = G.GAME.hands[k].chips }, card)
                    SMODS.calculate_effect(
                        { message = '+' .. tostring(G.GAME.hands[k].mult), mult_mod = G.GAME.hands[k].mult }, card)
                end
            end
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
