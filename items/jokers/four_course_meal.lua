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
            hands_left = 5,
            hand_decrement = 1,
            chips = 150,
            mult = 30,
            Xmult = 3,
            money = 10
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "hands_left",
                scalar_value = "hand_decrement",
                operation = "-",
                no_message = true
            })

            if stg.hands_left >= 4 then
                return {
                    chips = stg.chips,
                }
            elseif stg.hands_left >= 3 then
                return {
                    mult = stg.mult
                }
            elseif stg.hands_left >= 2 then
                return {
                    x_mult = stg.Xmult
                }
            elseif stg.hands_left >= 1 then
                ease_dollars(stg.money)
                return {
                    message = localize('$') .. stg.money,
                    colour = G.C.money,
                    card = card
                }
            end
        end

        if context.after and stg.hands_left <= 1 and not context.blueprint then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize('k_eaten_ex'),
                colour = G.C.RED
            }
        end
    end
}
