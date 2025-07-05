SMODS.Joker {
    key = 'hamill',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 7
    },
    soul_pos = {
        x = 5,
        y = 8
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
    config = {
        extra = {
            levels = 1
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "anerdymous"
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local hand = localize(mxms_get_most_played_hand(), 'poker_hands')

        return { vars = { stg.levels, hand } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        local most_played_hand = mxms_get_most_played_hand()
        if context.before and context.scoring_name == most_played_hand then
            SMODS.smart_level_up_hand(context.blueprint_card or card, most_played_hand, nil, stg.levels)
        end
    end
}

function mxms_get_most_played_hand()
    local _handname, _played, _order = 'High Card', -1, 100
    for k, v in pairs(G.GAME.hands) do
        if v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            _handname = k
        end
    end

    return _handname
end
