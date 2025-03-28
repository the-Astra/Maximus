SMODS.Joker {
    key = 'four_course_meal',
    loc_txt = {
        name = 'Four Course Meal',
        text = { 'For the next 4 hands,', 'give {C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult,', '{X:mult,C:white}X#3#{} Mult, and {C:money}$#4#{}', 'respectively' }
    },
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
                    message = '+' .. stg.chips,
                    chip_mod = stg.chips,
                    colour = G.C.chips,
                    card = card
                }
            elseif stg.hands <= 2 then
                return {
                    message = '+' .. stg.mult,
                    mult_mod = stg.mult,
                    colour = G.C.mult,
                    card = card
                }
            elseif stg.hands <= 3 then
                return {
                    message = 'X' .. stg.Xmult,
                    Xmult_mod = stg.Xmult,
                    colour = G.C.mult,
                    card = card
                }
            elseif stg.hands <= 4 then
                ease_dollars(stg.money)
                return {
                    message = '$' .. stg.money,
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
    end
}
