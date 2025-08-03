if Maximus_config.new_handtypes then
    SMODS.Consumable {
        key = 'poltergeist',
        set = 'Planet',
        atlas = 'Consumables',
        pos = {
            x = 5,
            y = 0
        },
        config = {
            hand_type = 'mxms_house_party',
            mxms_exoplanet = true,
        },
        mxms_credits = {
            art = { "Maxiss02" },
            code = { "theAstra" }
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
            if (G.GAME and G.GAME.starting_params.play_limit >= 6) then
                return true
            end

            return false
        end,
        set_card_type_badge = function(self, card, badges)
            badges[#badges + 1] = create_badge(localize('k_mxms_exoplanet'), get_type_colour(card.config.center, card),
            nil, 1.2)
        end
    }
else
    sendDebugMessage("Poltergeist not loaded; New Handtypes Disabled", 'Maximus')
end
