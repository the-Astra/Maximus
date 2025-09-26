SMODS.Joker {
    key = 'cork_board',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 2
        }
    },
    mxms_credits = {
        art = { "???" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.other_consumeable and context.other_consumeable.ability.set == 'Conspiracy' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_consumeable:juice_up()
                    return true;
                end
            }))
            return {
                x_mult = stg.Xmult,
                message_card = card
            }
        end
    end
}
