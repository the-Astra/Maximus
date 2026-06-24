SMODS.Consumable {
    key = 'gemini',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 2,
        y = 1
    },
    config = {
        hands = {},
        extra = {
            times = 0,
            goal = 3,
            upgrade = 2
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
            if card.ability.hands[context.scoring_name] then
                Maximus.horoscope_fail(card)
            else
                card.ability.hands[context.scoring_name] = true
                stg.times = stg.times + 1
                SMODS.calculate_effect({ message = stg.times .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
                if PlayLog then PlayLog.log({ type = 'mxms_horoscope_increment', card = card, tally = stg.tally }) end
            end

            if stg.times >= stg.goal then
                Maximus.horoscope_succeed(card)
            end
        end
    end,
    succeed = function(self, card, context)
        local stg = card.ability.extra

        local hands_to_upgrade = {}
        for k, v in pairs(card.ability.hands) do
            if v then
                table.insert(hands_to_upgrade, k)
            end
        end
        if next(hands_to_upgrade) then
            SMODS.upgrade_poker_hands({ hands = hands_to_upgrade, level_up = stg.upgrade, from = card })
        end
    end,
    reset = function(self, card)
        card.ability.extra.times = 0
        card.ability.hands = {}
    end,
    can_use = function(self, card) return false end,
    can_succeed = function(self, card) return card.ability.extra.times > 0 end
}
