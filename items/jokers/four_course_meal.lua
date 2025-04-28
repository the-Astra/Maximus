SMODS.Joker {
    key = 'four_course_meal',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 9
    },
    rarity = 3,
    config = {
        extra = {
            hands = 0,
            chips = 150,
            mult = 30,
            Xmult = 3,
            money = 10
        }
    },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 8,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.chips, stg.mult, stg.Xmult, stg.money } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            stg.hands = stg.hands + (1 * G.GAME.fridge_mod)
            if stg.hands <= 1 then
                return {
                    chips = stg.chips,
                }
            elseif stg.hands <= 2 then
                return {
                    mult = stg.mult
                }
            elseif stg.hands <= 3 then
                return {
                    x_mult = stg.Xmult
                }
            elseif stg.hands <= 4 then
                ease_dollars(stg.money)
                return {
                    message = localize('$') .. stg.money,
                    colour = G.C.money,
                    card = card
                }
            end
        end

        if context.after and stg.hands >= 4 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(self)
                            card:remove()
                            card = nil
                            return true;
                        end
                    }))
                    return true
                end
            }))
            return {
                message = localize('k_eaten_ex'),
                colour = G.C.RED
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
