SMODS.Joker {
    key = 'group_chat',
    loc_txt = {
        name = 'Group Chat',
        text = { 'Gains {C:chips}+#2#{} Chips', 'whenever another Joker scales', '{C:inactive}Currently: {C:chips}+#1#' }
    },
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
                chip_mod = stg.chips,
                message = '+' .. stg.chips,
                colour = G.C.CHIPS,
                card = card
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
    end
}
