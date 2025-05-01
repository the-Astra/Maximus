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
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
