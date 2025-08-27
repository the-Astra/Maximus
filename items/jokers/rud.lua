SMODS.Joker {
    key = 'rud',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 5
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.final_scoring_step and G.GAME.current_round.hands_left == 0
            and SMODS.calculate_round_score() + to_big(G.GAME.chips) < to_big(G.GAME.blind.chips) then
            return {
                Xmult = stg.Xmult,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve()
                            play_sound('mxms_eggsplosion')
                            return true;
                        end
                    }))
                end
            }
        end
    end
}
