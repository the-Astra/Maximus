SMODS.Joker {
    key = 'severed_floor',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 14
    },
    rarity = 2,
    config = {
        extra = {
            money = 20,
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.money }
        }
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money
    end
}

local ccsc = Card.can_sell_card
Card.can_sell_card = function(self, context)
    local ret = ccsc(self, context)
    if self.config.center_key == 'j_mxms_severed_floor' and G.STATE == G.STATES.ROUND_EVAL then
        ret = false
    end
    return ret
end
