SMODS.Consumable {
    key = 'vaccine',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 4,
        y = 0
    },
    config = {
        extra = {
            prob = 0,
            odds = 5,
            cards = 5
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
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky

        local consp_count = Maximus.count_conspiracy_cards()
        local prob, odds = SMODS.get_probability_vars(card, consp_count, stg.odds, 'vaccine')

        return { vars = { prob, odds, stg.cards } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'vaccine') then
            local i = 1
            for k, v in pairs(G.hand.cards) do
                if v:is_suit("Hearts") then
                    local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                    i = i + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            v:flip()
                            play_sound('card1', percent)
                            v:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
            end
            delay(0.2)
            for k, v in pairs(G.hand.cards) do
                if v:is_suit("Hearts") then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            v:set_ability(G.P_CENTERS.m_lucky)
                            return true
                        end
                    }))
                end
            end
            i = 1
            for k, v in pairs(G.hand.cards) do
                if v:is_suit("Hearts") then
                    local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                    i = i + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            v:flip()
                            play_sound('tarot2', percent, 0.6)
                            v:juice_up(0.3, 0.3)
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
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
