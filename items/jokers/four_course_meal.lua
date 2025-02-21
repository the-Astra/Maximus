SMODS.Joker {
    key = 'four_course_meal',
    loc_txt = {
        name = 'Four Course Meal',
        text = { 'For the next 4 hands,', 'give {C:chips}+150{} Chips, {C:mult}+30{} Mult,', '{X:mult,C:white}X3{} Mult, and {C:money}$10{}', 'respectively' }
    },
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 9
    },
    rarity = 3,
    config = {
        extra = {
            hands = 0
        }
    },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.hands = card.ability.extra.hands + (1 * G.GAME.fridge_mod)
            if card.ability.extra.hands <= 1 then
                return {
                    message = '+150',
                    chip_mod = 150,
                    colour = G.C.chips,
                    card = card
                }
            elseif card.ability.extra.hands <= 2 then
                return {
                    message = '+30',
                    mult_mod = 30,
                    colour = G.C.mult,
                    card = card
                }
            elseif card.ability.extra.hands <= 3 then
                return {
                    message = 'X3',
                    Xmult_mod = 3,
                    colour = G.C.mult,
                    card = card
                }
            elseif card.ability.extra.hands <= 4 then
                ease_dollars(10)
                return {
                    message = '$10',
                    colour = G.C.money,
                    card = card
                }
            end
        end

        if context.after and card.ability.extra.hands >= 4 then
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
    end
}