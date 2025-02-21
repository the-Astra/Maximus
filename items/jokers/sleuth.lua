SMODS.Joker {
    key = 'sleuth',
    loc_txt = {
        name = 'Sleuth',
        text = { '{C:attention}+1 card slot{}', 'available in the shop' }
    },
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 5
    },
    rarity = 1,
    config = {},
    blueprint_compat = false,
    cost = 6,
    add_to_deck = function(self, card, from_debuff)
        change_shop_size(1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-1)
    end
}