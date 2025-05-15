SMODS.Joker {
    key = 'sleuth',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 5
    },
    rarity = 1,
    config = {
        extra = {
            slots = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.slots }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        local stg = card.ability.extra
        change_shop_size(stg.slots)
    end,

    remove_from_deck = function(self, card, from_debuff)
        local stg = card.ability.extra
        change_shop_size(-stg.slots)
    end
}
