SMODS.Consumable {
    key = 'taurus',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = {
            hand_type = nil,
            times = 0,
            goal = 3,
            upgrade = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.goal, stg.upgrade, stg.times } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before then
            if not stg.hand_type then
                stg.hand_type = context.scoring_name
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
                if PlayLog then PlayLog.log({ type = 'mxms_horoscope_increment', card = card, tally = stg.times }) end
            elseif stg.hand_type == context.scoring_name then
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
                if PlayLog then PlayLog.log({ type = 'mxms_horoscope_increment', card = card, tally = stg.times }) end
            else
                Maximus.horoscope_fail(card)
            end

            if stg.times == stg.goal then
                Maximus.horoscope_succeed(card)
            end
        end
    end,
    succeed = function(self, card, context)
        local stg = card.ability.extra
        if stg.hand_type then
            SMODS.smart_level_up_hand(card, stg.hand_type, false, stg.upgrade)
        end
    end,
    reset = function(self, card)
        card.ability.extra.times = 0
    end,
    can_use = function(self, card) return false end,
    can_succeed = function(self, card) return card.ability.extra.hand_type end
}
