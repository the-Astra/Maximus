SMODS.Consumable {
    key = 'pyramid',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = {
            odds = 5
        }
    },
    mxms_credits = {
        art = { "pangaea47" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    cost = 4,
    pixel_size = {w = 69, h = 73},
    display_size = {w = 69, h = 73},
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = { set = 'Other', key = 'mxms_conspiracy_desc', vars = { SMODS.get_probability_vars(card, 1, 1, 'dummy') } }
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone

        local consp_count = Maximus.count_conspiracy_cards()

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'pyramid') } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'pyramid') then
            for k, v in pairs(G.hand.cards) do
                if v:is_suit("Spades") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
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
            end
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        local stg = card.ability.extra
        return #G.hand.cards > 0
    end
}
