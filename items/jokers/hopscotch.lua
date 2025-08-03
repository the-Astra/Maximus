---@diagnostic disable: undefined-field
SMODS.Joker {
    key = 'hopscotch',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 2
    },
    config = {
        extra = {
            prob = 1,
            odds = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { SMODS.get_probability_vars(card, stg.prob, stg.odds, 'hopscotch') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.setting_blind and G.GAME.round_resets.blind_tag and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'hopscotch', stg.prob, stg.odds) then
                play_sound('generic1')
                card:juice_up(0.3, 0.4)
                add_tag(G.GAME.round_resets.blind_tag)
                G.GAME.mxms_skip_tag = ''
            else
                return {
                    sound = 'tarot2',
                    card = card,
                    message = localize('k_nope_ex'),
                    colour = G.C.SET.Tarot
                }
            end
        end
    end
}
