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
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
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
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local front = pseudorandom_element(G.P_CARDS, pseudoseed('slide_fr'))
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local new_card = Card(G.play.T.x + G.play.T.w / 2, G.play.T.y, G.CARD_W, G.CARD_H, front,
                                G.P_CENTERS.m_stone, { playing_card = G.playing_card })
                            new_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                            G.deck:emplace(new_card)
                            table.insert(G.playing_cards, new_card)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced },
                        card)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                end
                playing_card_joker_effects({ true })
            end
        end
    end
}
