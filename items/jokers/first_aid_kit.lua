SMODS.Joker {
    key = 'first_aid_kit',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 9
    },
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    config = {
        extra = {
            hands = 2,
            discards = 2
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.hands, stg.discards }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
                    G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + stg.hands
                    hand_UI.config.object:update()
                    G.HUD:recalculate()
                    attention_text({
                        text = '+' .. stg.hands,
                        scale = 0.8,
                        hold = 0.7,
                        cover = hand_UI.parent,
                        cover_colour = G.C.GREEN,
                        align = 'cm',
                    })
                    play_sound('chips2')
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')
                    G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + stg.discards
                    discard_UI.config.object:update()
                    G.HUD:recalculate()
                    attention_text({
                        text = '+' .. stg.discards,
                        scale = 0.8,
                        hold = 0.7,
                        cover = discard_UI.parent,
                        cover_colour = G.C.GREN,
                        align = 'cm',
                    })
                    play_sound('chips2')
                    return true
                end
            }))
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_first_aid_kit',
    type = 'loss',
    extra = { center = 'j_mxms_first_aid_kit' }
}

SMODS.JimboQuip {
    key = 'wq_first_aid_kit',
    type = 'win',
    extra = { center = 'j_mxms_first_aid_kit' }
}
