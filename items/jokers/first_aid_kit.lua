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
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
