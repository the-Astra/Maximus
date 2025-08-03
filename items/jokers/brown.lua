SMODS.Joker {
    key = 'brown',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 17
    },
    rarity = 1,
    config = {
        extra = {
            gain = 0.5,
            Xmult = 1
        }
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        if G.hand then
            if G.GAME.starting_params.hand_size - G.hand.config.card_limit < 0 then
                stg.Xmult = 1
            else
                stg.Xmult = stg.gain * (G.GAME.starting_params.hand_size - G.hand.config.card_limit) + 1
            end
        end

        return {
            vars = { stg.gain, G.GAME.starting_params.hand_size or 8, stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and stg.Xmult > 1 then
            if G.GAME.starting_params.hand_size - G.hand.config.card_limit < 0 then
                stg.Xmult = 1
            else
                stg.Xmult = stg.gain * (G.GAME.starting_params.hand_size - G.hand.config.card_limit) + 1
            end
            return {
                x_mult = stg.Xmult
            }
        end
    end
}
