SMODS.Joker {
    key = 'rock_slide',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 9
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    enhancement_gate = 'm_stone',
    config = {
        extra = {
            stones = 5
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = { stg.stones }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before and #context.scoring_hand == 5 then
            local stone_tally = 0
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, 'm_stone') then
                    stone_tally = stone_tally + 1
                end
            end

            if stone_tally == 5 then
                for i = 1, stg.stones do
                    local _card = SMODS.create_card({
                        set = 'Playing Card',
                        area = G.discard,
                        enhancement = 'm_stone',
                        key_append = 'rock_slide'
                    })
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                            G.play:emplace(_card)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        message = localize('k_plus_stone'),
                        colour = G.C.SECONDARY_SET.Enhanced,
                        func = function() draw_card(G.play, G.deck, 90, 'up', nil, _card) end
                    }, context.blueprint or card)
                end
                playing_card_joker_effects({ true })
            end
        end
    end
}
