SMODS.Consumable {
    key = 'sighting',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 1,
        y = 2
    },
    config = {
        extra = {
            odds = 5,
            size = 1
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
        local prob, odds = SMODS.get_probability_vars(card, consp_count, stg.odds, 'sighting')

        return { vars = { prob, odds, stg.size } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'sighting') then
            G.GAME.round_resets.temp_handsize = G.GAME.round_resets.temp_handsize or 0
            G.GAME.round_resets.temp_handsize = G.GAME.round_resets.temp_handsize + stg.size
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up()
                    play_sound('tarot1')
                    G.hand:change_size(stg.size)
                    return true;
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        return true
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
