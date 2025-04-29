SMODS.Joker {
    key = 'all_in_favor',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            active = false
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.j_four_fingers
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.after and G.GAME.last_hand_played == 'Straight Flush' then
            stg.active = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                    return true;
                end
            }))
            return {
                message = localize('k_active_ex')
            }
        end

        if context.selling_self and stg.active then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({ key = 'j_four_fingers' })
                    card:juice_up()
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    return true;
                end
            }))
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
    end
}
