SMODS.Joker {
    key = 'tar_pit',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 16
    },
    rarity = 2,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 5,
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
    calculate = function(self, card, context)
        if context.before then
            for k, v in pairs(context.scoring_hand) do
                if v.seal and v.seal ~= 'mxms_black' then
                    v:set_seal('mxms_black')
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
