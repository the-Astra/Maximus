SMODS.Joker {
    key = 'hugo',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 7
    },
    soul_pos = {
        x = 2,
        y = 8
    },
    rarity = 4,
    unlocked = false,
    unlock_condition = {
        type = '',
        extra = '',
        hidden = true
    },
    config = {
        extra = {
            prob = 1,
            odds = 4
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { SMODS.get_probability_vars(card, stg.prob, stg.odds, 'hugo') }
        }
    end
}

local gfsb = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
    local hugos = SMODS.find_card('j_mxms_hugo')
    if next(hugos) and G.GAME.blind_on_deck ~= 'Boss' then
        for k, v in pairs(hugos) do
            if SMODS.pseudorandom_probability(v, 'hugo', v.ability.extra.prob, v.ability.extra.odds) then
                delay(0.2)
                SMODS.calculate_effect({ message = localize('k_skipped_cap') }, v)
                delay(0.2)
                G.FUNCS.skip_blind(e)
                return
            end
        end
    end
    gfsb(e)
end
