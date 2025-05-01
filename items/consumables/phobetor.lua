if Maximus_config.new_handtypes then
    SMODS.Consumable {
        key = 'phobetor',
        set = 'Planet',
        atlas = 'Consumables',
        pos = {
            x = 9,
            y = 0
        },
        config = {
            hand_type = 'mxms_f_party',
            softlock = true
        },
        cost = 4,
        loc_vars = function(self, info_queue, center)
            return {
                vars =
                {
                    G.GAME.hands[center.ability.hand_type].level,
                    localize(center.ability.hand_type, "poker_hands"),
                    G.GAME.hands[center.ability.hand_type].l_mult,
                    G.GAME.hands[center.ability.hand_type].l_chips,
                    colours = {
                        (G.GAME.hands[center.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[center.ability.hand_type].level)])
                    }
                },
            }
        end,
        in_pool = function(self, args)
            if (G.GAME.selected_back and G.GAME.selected_back.name == 'b_mxms_sixth_finger') then
                return true
            end

            return false
        end,
        set_card_type_badge = function(self, card, badges)
            badges[#badges + 1] = create_badge(localize('k_mxms_exoplanet'), get_type_colour(card.config.center), nil,
                1.2)
            if self.discovered then
                badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
            end
        end
    }
else
    sendDebugMessage("Phobetor not loaded; New Handtypes Disabled", 'Maximus')
end
