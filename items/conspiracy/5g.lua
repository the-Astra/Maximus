SMODS.Consumable {
    key = '5g',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 5,
        y = 1
    },
    config = {
        extra = {
            odds = 5,
            cards = 3
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
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil

        local consp_count = Maximus.count_conspiracy_cards()
        local prob, odds = SMODS.get_probability_vars(card, consp_count, stg.odds, '5g')

        return { vars = { prob, odds, stg.cards } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, '5g') then
            for k, v in pairs(G.hand.highlighted) do
                v:set_edition({ foil = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        card:juice_up()
                        return true;
                    end
                }))
            end
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        local stg = card.ability.extra

        return #G.hand.highlighted <= stg.cards and #G.hand.highlighted > 0
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
