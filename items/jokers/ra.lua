SMODS.Joker {
    key = 'ra',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 17
    },
    rarity = 3,
    config = {
        extra = {
            gain = 0.1,
            Xmult = 1
        }
    },
    credit = {
        art = "anerdymous",
        code = "theAstra",
        concept = "anerdymous"
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.after and context.scoring_name == 'High Card' and not context.blueprint then
            local destroyed_cards = {}
            for k, v in pairs(context.scoring_hand) do
                stg.Xmult = stg.Xmult + stg.gain * G.GAME.soil_mod
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        destroyed_cards[#destroyed_cards+1] = v
                        v:start_dissolve()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:remove()
                                v = nil
                                return true;
                            end
                        }))
                        return true;
                    end
                }))
                SMODS.calculate_effect({ message = localize('k_mxms_sacrifice_ex') }, card)
            end
            SMODS.calculate_context({remove_playing_card = true, removed = destroyed_cards})
        end

        if context.joker_main then
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
