SMODS.Joker {
    key = 'old_man_jimbo',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 1
    },
    rarity = 2,
    config = {
        extra = {
            gain = 0.5
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.gain } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            return {
                x_mult = 1 + (stg.gain * G.GAME.current_round.hands_left)
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_old_man_jimbo',
    type = 'loss',
    extra = {
        center = 'j_mxms_old_man_jimbo',
        times = 30,
        delay = 0.2
    }
}

SMODS.JimboQuip {
    key = 'wq_old_man_jimbo',
    type = 'win',
    extra = { center = 'j_mxms_old_man_jimbo' }
}
