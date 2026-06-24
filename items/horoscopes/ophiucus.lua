SMODS.Consumable {
    key = 'ophiucus',
    set = 'Spectral',
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 2
    },
    config = {
        extra = {
            hands = {},
            antes = 0,
            ante_limit = 2,
            handtypes_played = 0
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    hidden = true,
    soul_set = 'Horoscope',
    soul_rate = 0.003,
    select_card = 'mxms_horoscope',
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
        return { vars = { stg.handtypes_played, stg.ante_limit } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before and not stg.hands[context.scoring_name] then
            stg.hands[context.scoring_name] = true
            stg.handtypes_played = stg.handtypes_played + 1
            SMODS.calculate_effect({ message = stg.handtypes_played .. "/9", colour = Maximus.C.HOROSCOPE }, card)
            if PlayLog then PlayLog.log({ type = 'mxms_horoscope_increment', card = card, tally = stg.handtypes_played }) end

            local all_hands = true
            for k, v in pairs(stg.hands) do
                if not v then
                    all_hands = false
                    break
                end
            end
            if all_hands then
                Maximus.horoscope_succeed(card)
            end
        end

        if context.ante_change and context.ante_end then
            stg.antes = stg.antes + 1
            if stg.antes >= stg.ante_limit then
                Maximus.horoscope_fail(card)
            else
                SMODS.calculate_effect(
                { message = stg.ante_limit - stg.antes .. " Ante Left...", colour = Maximus.C.HOROSCOPE }, card)
            end
        end
    end,
    succeed = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.4)

                SMODS.add_card({
                    set = 'Spectral',
                    key = 'c_soul',
                    edition = 'e_negative',
                    key_append = 'oph'
                })
                return true;
            end
        }))
    end,
    reset = function(self, card)
        card.ability.extra.hands = {}
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_horoscope'), Maximus.C.SET.Horoscope, G.C.WHITE, 1.2)
        end
    end,
    can_use = function(self, card) return false end,
    can_succeed = function(self, card) return true end
}
