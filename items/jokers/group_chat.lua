SMODS.Joker {
    key = 'group_chat',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0,
            gain = 2
        }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.chips > 0 then
            return {
                chips = stg.chips
            }
        end

        if context.scaling_card and not context.blueprint then
            stg.chips = stg.chips + stg.gain * G.GAME.soil_mod
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:juice_up(0.3, 0.4)
                    return true
                end
            }))
        end
    end,
    set_ability = function(self, card, inital, delay_sprites)
        local W = card.T.w
        W = W * (66 / 71)
        card.children.center.scale.x = card.children.center.scale.x * (66 / 71)
        card.T.w = W
    end
}
