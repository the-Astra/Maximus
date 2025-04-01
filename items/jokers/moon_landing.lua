SMODS.Joker {
    key = 'moon_landing',
    loc_txt = {
        name = 'Moon Landing',
        text = {
            'The {C:attention}second highest level{}',
            'hand type gives {C:chips}Chips{} and {C:mult}mult{} equal to',
            'the {C:attention}highest level{} hand type'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before then
            local hand_is_second = false
            local high_level, second_level, highest, second = 0, 0, {}, {}

            for k, v in pairs(G.GAME.hands) do
                if v.visible and v.level > high_level then
                    high_level = v.level
                    highest = { k }
                elseif v.visible and v.level == highest then
                    highest[#highest + 1] = k
                elseif v.visible and v.level > second_level and v.level < high_level then
                    second_level = v.level
                    second = { k }
                elseif v.visible and v.level == second_level then
                    second[#second + 1] = k
                end
            end

            for i = 1, #second do
                if context.scoring_name == second[i] then
                    hand_is_second = true
                end
            end

            if hand_is_second then
                local best_choice
                local best_value = 0

                for i = 1, #highest do
                    if G.GAME.hands[highest[i]].chips * G.GAME.hands[highest[i]].mult > best_value then
                        best_value = G.GAME.hands[highest[i]].chips * G.GAME.hands[highest[i]].mult
                        best_choice = highest[i]
                    end
                end

                hand_chips = G.GAME.hands[best_choice].chips
                mult = G.GAME.hands[best_choice].mult

                update_hand_text = ({mult = G.GAME.hands[best_choice].mult, chips = G.GAME.hands[best_choice].chips})

                return {
                    message = 'One Small Step',
                    colour = G.C.ATTENTION,
                    card = card
                }
            end
        end
    end
}
