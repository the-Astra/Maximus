SMODS.Joker {
    key = 'substitute',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 19
    },
    rarity = 1,
    config = {
        extra = {
            prevents = 2
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.prevents }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_type_destroyed and stg.prevents > 0 then
            stg.prevents = stg.prevents - 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    return true;
                end
            }))
            return {
                no_destroy = true,
                message_card = context.card,
                message = localize('k_saved_ex'),
                func = function()
                    if stg.prevents <= 0 then
                        SMODS.destroy_cards(card, nil, nil, true)
                        SMODS.calculate_effect({ message = localize('k_mxms_fainted'), colour = G.C.ATTENTION },card)
                    end
                end
            }
        end
    end
}
