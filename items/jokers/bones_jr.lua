SMODS.Joker {
    key = 'bones_jr',
    pos = {
        x = 3,
        y = 4
    },
    rarity = 1,
    config = {
        extra = {
            extra_hands = 1
        }
    },
    mxms_credits = {
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        local hands = G.GAME.starting_params.hands
        if not hands then
            hands = 4
        end

        return {
            vars = { hands, stg.extra_hands }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.after and not context.blueprint and
            hand_chips * mult < G.GAME.blind.chips / G.GAME.starting_params.hands then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    ease_hands_played(stg.extra_hands, true)
                    card:start_dissolve()
                    return true
                end
            }))
            return {
                message = localize('k_mxms_plus_hand'),
                colour = G.C.BLUE
            }
        end
    end,
    set_ability = function(self, card, inital, delay_sprites)
        if card.config.center.discovered or card.bypass_discovery_center then
            local W, H = card.T.w, card.T.h
            H = H * 0.7
            W = W * 0.7
            card.T.h = H
            card.T.w = W
        end
    end,
    load = function(self, card, card_table, other_card)
        local W, H, scale = card.T.w, card.T.h, 1

        card.T.h = H * scale * 0.7 * scale
        card.T.w = W * scale * 0.7 * scale
    end
}
