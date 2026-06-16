SMODS.Consumable {
    key = 'tinfoil',
    set = 'Conspiracy',
    atlas = 'Conspiracy',
    pos = {
        x = 0,
        y = 2
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

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, 'tinfoil') } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        if Maximus.poll_conspiracy_chance(card, stg.odds, 'tinfoil') then
            G.GAME.blind:disable()
            play_sound('timpani')
            SMODS.calculate_effect({ message = localize('ph_boss_disabled')},card)
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        local stg = card.ability.extra
        
        return G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled
    end,
    in_pool = function(self, args)
        return Maximus_config.conspiracies
    end
}
