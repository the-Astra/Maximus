SMODS.Joker {
    key = 'normal',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 1
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    config = {
        extra = {
            mult = 2,
            chips = 15
        }
    },
    discovered = true,
    order = 2,
    rarity = 1,
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.mult, stg.chips } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if card.area ~= G.title_top and context.individual and context.cardarea == G.play then
            if not context.other_card.edition and not context.other_card.seal and not next(SMODS.get_enhancements(context.other_card)) then
                return {
                    mult = stg.mult,
                    chips = stg.chips,
                    card = card
                }
            end
        end
    end,
}

SMODS.JimboQuip {
    key = 'lq_normal',
    type = 'loss',
    extra = { center = 'j_mxms_normal' }
}

SMODS.JimboQuip {
    key = 'wq_normal',
    type = 'win',
    extra = { center = 'j_mxms_normal' }
}
