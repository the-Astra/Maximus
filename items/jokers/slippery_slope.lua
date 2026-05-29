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
    attributes = {
        'chips',
        'mult',
        'hand_type'
    },
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in pairs(context.poker_hands) do
                if k ~= context.scoring_name and SMODS.PokerHands[k] and next(v) then
                    SMODS.calculate_effect(
                    { mult = SMODS.PokerHands[k].mult, chips = SMODS.PokerHands[k].chips, remove_default_message = true,
                    message = localize(k, 'poker_hands'), colour = G.C.PURPLE, sound = 'xchips' }, context.blueprint_card or card)
                end
            end
        end
    end
}
