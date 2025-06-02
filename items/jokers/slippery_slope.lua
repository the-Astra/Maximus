SMODS.Joker {
    key = 'slippery_slope',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 11
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            for k, v in pairs(context.poker_hands) do
                if k ~= context.scoring_name and next(context.poker_hands[k]) then
                    SMODS.calculate_effect({ message = G.localization.misc.poker_hands[k], colour = G.C.ATTENTION }, context.blueprint or card)
                    SMODS.calculate_effect(
                        { message = '+' .. tostring(G.GAME.hands[k].chips), chip_mod = G.GAME.hands[k].chips }, context.blueprint or card)
                    SMODS.calculate_effect(
                        { message = '+' .. tostring(G.GAME.hands[k].mult), mult_mod = G.GAME.hands[k].mult }, context.blueprint or card)
                end
            end
        end
    end
}
