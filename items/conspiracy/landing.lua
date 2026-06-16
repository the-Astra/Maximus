SMODS.Consumable {
    key = 'landing',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 4,
        y = 1
    },
    config = {
        extra = {
            odds = 5,
            levels = 2
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
        local prob, odds = SMODS.get_probability_vars(card, consp_count, stg.odds, 'landing')

        return { vars = { prob, odds, stg.levels } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'landing') then
            local level, lowest = nil, {}

            for k, v in pairs(G.GAME.hands) do
                if v.visible and (not level or to_big(v.level) < level) then
                    level = to_big(v.level)
                    lowest = { k }
                elseif v.visible and to_big(v.level) == level then
                    lowest[#lowest + 1] = k
                end
            end

            local chosen_hand = pseudorandom_element(lowest, pseudoseed('landing'))

            SMODS.smart_level_up_hand(card, chosen_hand)
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
