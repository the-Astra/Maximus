SMODS.Joker {
    key = 'detective',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 15
    },
    rarity = 1,
    config = {
        extra = {
            size = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = false,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        return { vars = { stg.size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        local stg = card.ability.extra

        G.hand:change_size(stg.size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        local stg = card.ability.extra

        G.hand:change_size(-stg.size)
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.draw_individual and context.num_drawn <= stg.size and not context.to_booster then
            return {
                stay_flipped = true
            }
        end
    end,
}

SMODS.JimboQuip {
    key = 'lq_detective',
    type = 'loss',
    extra = { center = 'j_mxms_detective' }
}

SMODS.JimboQuip {
    key = 'wq_detective',
    type = 'win',
    extra = { center = 'j_mxms_detective' }
}
