SMODS.Joker {
    key = 'space_race',
    loc_txt = {
        name = 'Space Race',
        text = { 'If played hand is not the highest', 'level hand, upgrade hand by one level',
            '{C:inactive}Hands tied for highest do not upgrade{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 5
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
            local hand_is_highest = false

            local hand, level, highest = nil, 0, {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and v.level > level then
                    hand = k
                    level = v.level
                    highest = { hand }
                elseif v.visible and v.level == level then
                    highest[#highest + 1] = k
                end
            end

            for i = 1, #highest do
                if context.scoring_name == highest[i] then
                    hand_is_highest = true
                end
            end

            if not hand_is_highest then
                return {
                    card = card,
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}