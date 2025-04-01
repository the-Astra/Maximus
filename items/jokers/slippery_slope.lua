SMODS.Joker {
    key = 'slippery_slope',
    loc_txt = {
        name = 'Slippery Slope',
        text = { 
            'If hand contains {C:attention}more than one{} hand', 
            'type, add {C:chips}Chips{} and {C:mult}Mult{} from {C:attention}all{}', 
            'contained hand types to score' 
        }
    },
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
            for k,v in pairs(context.poker_hands) do
                if k ~= context.scoring_name and next(context.poker_hands[k]) then
                   SMODS.calculate_effect({ message = G.localization.misc.poker_hands[k], colour = G.C.ATTENTION },card)
                   SMODS.calculate_effect({ message = '+' .. tostring(G.GAME.hands[k].chips), chip_mod = G.GAME.hands[k].chips }, card)
                   SMODS.calculate_effect({ message = '+' .. tostring(G.GAME.hands[k].mult), mult_mod = G.GAME.hands[k].mult }, card)
                end
            end
        end
    end
}
