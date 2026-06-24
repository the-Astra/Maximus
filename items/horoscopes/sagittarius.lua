SMODS.Consumable {
    key = 'sagittarius',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 8,
        y = 1
    },
    cost = 4,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            Maximus.horoscope_succeed(card)
        end
        if context.pre_discard then
            Maximus.horoscope_fail(card)
        end
    end,
    succeed = function(self, card)
        G.GAME.mxms_sagittarius_bonus = true
    end,
    can_use = function(self, card) return false end,
    can_succeed = function(self, card) return true end
}
