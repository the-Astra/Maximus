SMODS.Joker {
    key = 'substitute',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            prevents = 2
        }
    },
    mxms_credits = {
        art = { "???" },
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
                    context.card:juice_up()
                    return true;
                end
            }))
            return {
                no_destroy = true,
                message = localize('k_saved_ex'),
                func = function()
                    if stg.prevents <= 0 then
                        SMODS.destroy_cards(card)
                    end
                end
            }
        end
    end
}
