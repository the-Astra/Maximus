SMODS.Joker {
    key = 'minimalist',
    loc_txt = {
        name = 'Minimalist',
        text = { '{C:chips}+90{} Chips, {C:chips}-15{} for', 'every enhanced card in full deck', '{C:inactive}Currently: {C:chips}+#1#' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            chips = 90
        }
    },
    blueprint_compat = true,
    cost = 4,
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
    end,
    update = function(self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.chips = 90
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) and card.ability.extra.chips > 0 then
                    card.ability.extra.chips = card.ability.extra.chips - 15
                end
            end
        end
    end
}