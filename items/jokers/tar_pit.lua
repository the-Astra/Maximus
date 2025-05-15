SMODS.Joker {
    key = 'tar_pit',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            active = false
        }
    },
    credit = {
        art = "pinkzigzagoon",
        code = "theAstra",
        concept = "pinkzigzagoon"
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_SEALS['mxms_Black']
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before then
            for k, v in pairs(context.scoring_hand) do
                if v.seal and v.seal ~= 'mxms_Black' then
                    v:set_seal('mxms_Black')
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.50,
                        func = function()
                            play_sound('card1')
                            card:juice_up(0.3, 0.3)
                            v:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
            end
        end
    end
}
