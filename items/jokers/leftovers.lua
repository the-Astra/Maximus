SMODS.Joker {
    key = 'leftovers',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 2
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 4,
    pools = {
        Food = true
    },
    rarity = 1,
    calculate = function(self, card, context)
        local stg = card.ability.extra
    
        if context.joker_type_destroyed and context.card.config.center.pools.Food and not context.card.config.center_key == 'j_mxms_leftovers' then
            local respawn_key = context.card.config.center_key
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        key = respawn_key,
                        key_append = 'lefto'
                    }
                    return true;
                end
            }))

            SMODS.destroy_cards(card, nil, nil, true)

            return {
                message = 'k_mxms_saved_later_ex',
                colour = G.C.FILTER,
                sound = 'tarto1'
            }
        end
    end,
}

SMODS.JimboQuip {
    key = 'lq_leftovers',
    type = 'loss',
    extra = { center = 'j_mxms_leftovers' }
}