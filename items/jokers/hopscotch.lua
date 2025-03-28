SMODS.Joker {
    key = 'hopscotch',
    loc_txt = {
        name = 'Hopscotch',
        text = { 'When selecting blind,', '{C:green}#1# in #2#{} chance to', 'receive associated skip tag' }
    },
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
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.prob * G.GAME.probabilities.normal, stg.odds }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.setting_blind and G.GAME.blind:get_type() ~= 'Boss' and not context.blueprint then
            if pseudorandom(pseudoseed('hopscotch' .. G.GAME.round_resets.ante)) < stg.prob * G.GAME.probabilities.normal / stg.odds then
                local _tag = G.GAME.skip_tag
                if _tag and _tag.config then
                    play_sound('generic1')
                    card:juice_up(0.3, 0.4)
                    add_tag(_tag.config.ref_table)
                    G.GAME.skip_tag = ''
                end
            else
                SMODS.calculate_context({failed_prob = true, odds = stg.odds - (stg.prob * G.GAME.probabilities.normal)})
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
