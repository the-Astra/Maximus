SMODS.Consumable {
    key = 'cancer',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 3,
        y = 1
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_mxms_crab']
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            if G.GAME.current_round.hands_left == 0 then
                Maximus.horoscope_succeed(card)
            else
                Maximus.horoscope_fail(card)
            end
        end
    end,
    succeed = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_mxms_crab'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end)
        }))
    end,
    can_use = function(self, card) return false end,
    can_succeed = function(self, card) return true end
}
