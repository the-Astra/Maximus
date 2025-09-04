SMODS.Sticker {
    key = "posted",
    badge_colour = HEX 'fda200',
    pos = { x = 10, y = 10 },
    rate = 0,
    default_compat = false,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end
}
