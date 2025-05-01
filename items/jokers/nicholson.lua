SMODS.Joker {
    key = 'nicholson',
    atlas = 'Placeholder',
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = 1
    },
    rarity = 4,
    unlocked = false,
    unlock_condition = {
        type = '', 
        extra = '', 
        hidden = true
    },
    blueprint_compat = true,
    cost = 20,
    calculate = function(self, card, context)
        if context.other_card and context.other_card.edition and
            (context.repetition and context.cardarea == G.play or
                context.retrigger_joker_check and not context.retrigger_joker) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra,
                card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': ???', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
