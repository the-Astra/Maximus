SMODS.Joker {
    key = 'pizza',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 13
    },
    rarity = 1,
    config = {
        extra = {
            cards_left = 8,
            card_decrement = 1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = false,
    perishable_compat = false,
    eternal_compat = false,
    cost = 4,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.cards_left }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if not v.seal and not v.debuff and not v.pizza_sealed and stg.cards_left > 0 then
                    v.pizza_sealed = true
                    v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'pza' }))
                    SMODS.scale_card(card, {
                        ref_table = stg,
                        ref_value = "cards_left",
                        scalar_value = "card_decrement",
                        operation = "-",
                        no_message = true
                    })

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            card:juice_up()
                            v.pizza_sealed = nil
                            return true
                        end
                    }))

                    if stg.cards_left <= 0 then
                        SMODS.destroy_cards(card, nil, nil, true)
                        return {
                            card = card,
                            message = localize('k_eaten_ex'),
                            colour = G.C.FILTER
                        }
                    end
                end
            end
        end
    end
}
