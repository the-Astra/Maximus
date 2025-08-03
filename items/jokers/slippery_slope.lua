SMODS.Joker {
    key = 'slippery_slope',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 11
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in pairs(context.poker_hands) do
                if k ~= context.scoring_name and SMODS.PokerHands[k] and next(v) then
                    SMODS.calculate_effect({ message = localize(k, 'poker_hands'), colour = G.C.ATTENTION },
                        context.blueprint_card or card)
                    SMODS.calculate_effect({ chips = SMODS.PokerHands[k].chips }, context.blueprint_card or card)
                    SMODS.calculate_effect({ mult = SMODS.PokerHands[k].mult }, context.blueprint_card or card)
                end
            end
        end
    end
}
