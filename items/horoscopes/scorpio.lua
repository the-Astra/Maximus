SMODS.Consumable {
    key = 'scorpio',
    set = 'Horoscope',
    atlas = 'Consumables',
    pos = {
        x = 7,
        y = 1
    },
    config = {
        extra = {
            hands = 0,
            goal = 4,
            upgrade = 5,
            most_played_hand = 'High Card'
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

        if G.GAME.hands then
            local _handname, _played, _order = 'High Card', -1, 100
            for k, v in pairs(G.GAME.hands) do
                if v.played > _played or (v.played == _played and _order > v.order) then
                    _played = v.played
                    _handname = k
                end
            end
            stg.most_played_hand = _handname
        end

        return { vars = { stg.goal, stg.upgrade, stg.hands } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before then
            local _handname, _played, _order = 'High Card', -1, 100
            for k, v in pairs(G.GAME.hands) do
                if v.played > _played or (v.played == _played and _order > v.order) then
                    _played = v.played
                    _handname = k
                end
            end
            stg.most_played_hand = _handname

            if stg.most_played_hand == context.scoring_name then
                Maximus.horoscope_fail(card)
            else
                stg.hands = stg.hands + 1
                SMODS.calculate_effect({ message = stg.hands .. "/" .. stg.goal, colour = Maximus.C.HOROSCOPE }, card)
                if PlayLog then PlayLog.log({ type = 'mxms_horoscope_increment', card = card, tally = stg.hands }) end

                if stg.hands >= stg.goal then
                    Maximus.horoscope_succeed(card)
                end
            end
        end
    end,
    succeed = function(self, card, context)
        local stg = card.ability.extra
        SMODS.smart_level_up_hand(card, stg.most_played_hand, false, stg.upgrade)
    end,
    reset = function(self, card)
        card.ability.extra.hands = 0
    end,
    can_use = function(self, card) return false end,
    can_succeed = function(self, card) return card.ability.extra.most_played_hand end
}
