SMODS.Joker {
    key = 'detective',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            size = 3
        }
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
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
