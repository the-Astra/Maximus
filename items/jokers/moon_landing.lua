SMODS.Joker {
    key = 'moon_landing',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 11
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.post_handtype_scoring then

            local hand_is_second = false
            local high_level, second_level, highest, second = to_big(0), to_big(0), {}, {}

            for k, v in pairs(G.GAME.hands) do
                if v.visible and to_big(v.level) > high_level then
                    high_level = to_big(v.level)
                    highest = { k }
                elseif v.visible and to_big(v.level) == highest then
                    highest[#highest + 1] = k
                elseif v.visible and to_big(v.level) > second_level and to_big(v.level) < high_level then
                    second_level = to_big(v.level)
                    second = { k }
                elseif v.visible and to_big(v.level) == second_level then
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
                local best_value = to_big(0)

                for i = 1, #highest do
                    if to_big(G.GAME.hands[highest[i]].chips * G.GAME.hands[highest[i]].mult) > best_value then
                        best_value = to_big(G.GAME.hands[highest[i]].chips * G.GAME.hands[highest[i]].mult)
                        best_choice = highest[i]
                    end
                end

                update_hand_text(
                    { sound = 'chips2', volume = 0.7, pitch = 1.1, delay = 0 },
                    { mult = G.GAME.hands[best_choice].mult, chips = G.GAME.hands[best_choice].chips }
                )

                return {
                    message = localize('k_mxms_step_el'),
                    colour = G.C.ATTENTION,
                    card = card,
                    func = function()
                        hand_chips = mod_chips(G.GAME.hands[best_choice].chips)
                        mult = mod_mult(G.GAME.hands[best_choice].mult)
                    end
                }
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
