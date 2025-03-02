SMODS.Joker {
    key = 'crowned',
    loc_txt = {
        name = 'Crowned Joker',
        text = { '{X:mult,C:white}X#1#{} Mult' },
        unlock = { 'Trigger a {C:attention}Coronation{}' }
    },
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
                Xmult_mod = stg.Xmult,
                message = 'X' .. stg.Xmult,
                colour = G.C.MULT,
                card = card
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
