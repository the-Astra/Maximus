SMODS.Joker {
    key = 'adrenaline',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 18
    },
    rarity = 3,
    config = {
        extra = {
            hand_size = 2,
            discards = 2,
            active = false
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {stg.hand_size, stg.discards}
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.drawing_cards and G.GAME.current_round.hands_left == 1 and not stg.active then
            ease_discard(stg.discards)
            G.hand:change_size(stg.hand_size)
            stg.active = true
            return {
                message = localize('k_active_ex')
            }
        end

        if context.end_of_round and not context.game_over and stg.active then
            G.hand:change_size(-stg.hand_size)
            stg.active = false
            return {
                message = localize('k_reset')
            }
        end
    end
}
