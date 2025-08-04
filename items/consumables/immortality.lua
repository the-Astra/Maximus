SMODS.Consumable {
    key = 'immortality',
    set = 'Spectral',
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 3
    },
    config = {
        extra = 'mxms_black'
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS['mxms_black']

        return {
            vars = {
                colours = {
                    G.C.BLACK,
                    G.C.WHITE
                }
            }
        }
    end,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 1
    end
}
