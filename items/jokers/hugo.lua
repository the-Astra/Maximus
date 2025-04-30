SMODS.Joker {
    key = 'hugo',
    atlas = 'Placeholder',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 4,
    config = {
        extra = {
            prob = 1,
            odds = 4
        }
    },
    blueprint_compat = false,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        return { vars = { stg.prob * G.GAME.probabilities.normal, stg.odds } }
    end,
    set_badges = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}

local gfsb = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
    local hugos = SMODS.find_card('j_mxms_hugo')
    if next(hugos) and G.GAME.blind_on_deck ~= 'Boss' then
        for k, v in pairs(hugos) do
            if pseudorandom('hugo') < (v.ability.extra.prob * G.GAME.probabilities.normal) / v.ability.extra.odds then
                delay(0.2)
                SMODS.calculate_effect({ message = localize('k_skipped_cap') }, v)
                SMODS.calculate_context({ failed_prob = true, odds = v.ability.extra.odds -
                (v.ability.extra.prob * G.GAME.probabilities.normal) })
                delay(0.2)
                G.FUNCS.skip_blind(e)
                return
            end
        end
    end
    gfsb(e)
end
