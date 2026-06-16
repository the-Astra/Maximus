SMODS.Consumable {
    key = 'nwo',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 5,
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

        local consp_count = Maximus.count_conspiracy_cards()

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'society') } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'nwo') then
            for k, v in pairs(G.hand.cards) do
                if v:is_suit("Clubs") then
                    local eligible_jokers = {}
                    for kk, vv in pairs(G.jokers.cards) do
                        if not vv.edition or vv.marked_for_edition then
                            eligible_jokers[#eligible_jokers + 1] = vv
                        end
                    end

                    if next(eligible_jokers) then
                        local chosen_joker = pseudorandom_element(eligible_jokers, pseudoseed('society'))
                        chosen_joker.marked_for_edition = true
                        local _edition = poll_edition('society', nil, nil, true)

                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                chosen_joker.marked_for_edition = nil

                                chosen_joker:set_edition(_edition, true)
                                card:juice_up()
                                return true;
                            end
                        }))
                    end
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
