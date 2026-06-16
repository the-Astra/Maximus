SMODS.Consumable {
    key = 'corruption',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = {
            odds = 5,
            money = 5
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
        local prob, odds = SMODS.get_probability_vars(card, consp_count, stg.odds, 'corruption')

        return { vars = { prob, odds, stg.money } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'corruption') then
            for k, v in pairs(G.hand.cards) do
                if v:is_suit("Diamonds") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                    ease_dollars(stg.money)
                    SMODS.calculate_effect({ message = localize('$') .. stg.money, colour = G.C.MONEY }, card)
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
