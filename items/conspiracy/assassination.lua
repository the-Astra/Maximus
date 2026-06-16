SMODS.Consumable {
    key = 'assassination',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            seal = 'Red',
            odds = 5
        }
    },
    mxms_credits = {
        art = { "SadCube" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    cost = 4,
    pixel_size = {w = 69, h = 73},
    display_size = {w = 69, h = 73},
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = { set = 'Other', key = 'mxms_conspiracy_desc', vars = { SMODS.get_probability_vars(card, 1, 1, 'dummy') } }
        info_queue[#info_queue + 1] = G.P_SEALS['Red']

        local consp_count = Maximus.count_conspiracy_cards()

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'assassination') } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'assassination') then
            local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('assassination'))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    chosen_joker:start_dissolve()
                    card:juice_up(0.8, 0.8)
                    return true;
                end
            }))
            local i = 1
            for k, v in pairs(G.hand.cards) do
                if not v.seal then
                    local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                    i = i + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            v:set_seal(stg.seal, true, true)
                            play_sound('card1', percent)
                            return true;
                        end
                    }))
                end
            end
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        local stg = card.ability.extra
        return G.jokers and #G.jokers.cards > 0 and #G.hand.cards > 0
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
