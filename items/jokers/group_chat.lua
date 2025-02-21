SMODS.Joker {
    key = 'group_chat',
    loc_txt = {
        name = 'Group Chat',
        text = { 'Gains {C:chips}+2{} Chips', 'whenever another Joker scales', '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0
        }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}