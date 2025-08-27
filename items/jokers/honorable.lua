SMODS.Joker {
    key = 'honorable',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 15
    },
    rarity = 1,
    config = {
        extra = {
            mult = 0,
            gain = 10
        }
    },
    mxms_credits = {
        art = { "pinkzigzaoon" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_judgement
        local stg = card.ability.extra
        return {
            vars = { stg.gain, stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.mxms_judgement_used and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.card:start_dissolve()
                    return true;
                end
            }))
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "mult",
                scalar_value = "gain"
            })
            return nil, true
        end

        if context.joker_main and stg.mult > 0 then
            return {
                mult = stg.mult
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_honorable',
    type = 'loss',
    extra = { center = 'j_mxms_honorable' }
}