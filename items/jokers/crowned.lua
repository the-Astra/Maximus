SMODS.Joker {
    key = 'crowned',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 10
    },
    rarity = 1,
    config = {
        extra = {
            Xmult = 6
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        concept = { "Maxiss02" }
    },
    blueprint_compat = true,
    unlocked = false,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    check_for_unlock = function(self, args)
        return next(SMODS.find_card('j_mxms_crowned'))
    end
}

SMODS.JimboQuip {
    key = 'lq_crowned',
    type = 'loss',
    extra = {
        center = 'j_mxms_crowned',
        times = 1
    }
}

SMODS.JimboQuip {
    key = 'wq_crowned',
    type = 'win',
    extra = { center = 'j_mxms_crowned' }
}
