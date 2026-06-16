SMODS.Consumable {
    key = 'flat_earth',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 3,
        y = 1
    },
    config = {
        extra = {
            odds = 5,
            cards = 2
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
        info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']

        local consp_count = Maximus.count_conspiracy_cards()
        local prob, odds = SMODS.get_probability_vars(card, consp_count, stg.odds, 'flat_earth')

        return { vars = { prob, odds, stg.cards } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'flat_earth') then
            for i = 1, stg.cards do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({set = 'Planet', edition = 'e_negative'})
                        return true
                    end
                }))
                SMODS.calculate_effect({ message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Enhanced }, card)
            end
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        local stg = card.ability.extra
        
        return true
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
