SMODS.Joker {
    key = 'breadsticks',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            d_requirement = 2,
            d_tally = 0,
            chips = 0,
            dChips = 25
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 4,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.d_requirement, stg.chips, stg.dChips }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.discard and not context.blueprint and not context.other_card.debuff then
            stg.d_tally = stg.d_tally + 1
            if stg.d_tally < stg.d_requirement then
                return {
                    delay = 0.2,
                    message = stg.d_tally .. '/' .. stg.d_requirement,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "chips",
                    scalar_value = "dChips",
                    message_colour = G.C.CHIPS
                })
                stg.d_tally = 0
                return {
                    delay = 0.2,
                    func = function()
                        G.GAME.mxms_breadstick_scales = G.GAME.mxms_breadstick_scales + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                check_for_unlock({ type = 'stuffed', scales = G.GAME.mxms_breadstick_scales })
                                return true;
                            end
                        }))
                    end
                }
            end
        end

        if context.joker_main and stg.chips > 0 then
            return {
                chips = stg.chips
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            stg.d_tally = 0
            stg.chips = 0
            stg.d_requirement = stg.d_requirement + 1
            return {
                message = localize('k_mxms_more_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}
