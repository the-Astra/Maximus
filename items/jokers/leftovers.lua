SMODS.Joker {
    key = 'leftovers',
    loc_txt = {
        name = 'Leftovers',
        text = { 'Creates a new copy of', 'a {C:attention}Food{} Joker when', 'depleted or destroyed',
            '{C:inactive}Self-destructs on copy{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 2
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 4,
    rarity = 1,
    calculate = function(self, card, context)
        if G.GAME.destroyed_food ~= '' and not context.blueprint then
            local respawn_key = G.GAME.destroyed_food
            G.GAME.destroyed_food = ''

            G.E_MANAGER:add_event(Event({
                delay = 0.3,
                func = function()
                    play_sound('timpani')

                    SMODS.add_card({
                        set = 'Joker',
                        key = respawn_key,
                        key_append = 'lefto'
                    })

                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                            return true;
                        end
                    }))
                    return true
                end
            }))
            return {
                card = card,
                message = 'Saved for later!'
            }
        end
    end
}