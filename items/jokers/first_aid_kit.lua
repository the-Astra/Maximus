SMODS.Joker {
    key = 'first_aid_kit',
    loc_txt = {
        name = 'First Aid Kit',
        text = { 'Sell this card for', '{C:blue}+2{} hands and {C:red}+2{} discards', 'for the current round' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 9
    },
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
                    G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 2
                    hand_UI.config.object:update()
                    G.HUD:recalculate()
                    attention_text({
                        text = '+' .. 2,
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
                    G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + 2
                    discard_UI.config.object:update()
                    G.HUD:recalculate()
                    attention_text({
                        text = '+' .. 2,
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