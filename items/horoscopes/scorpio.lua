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
                    self:succeed(card, context)
                end
            end
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.mxms_zodiac_killer then
            return G.GAME.zodiac_killer_pools["Scorpio"] and G.GAME.round_resets.ante > 1
        end
        return true
    end,
    succeed = function(self, card, context)
        card.succeeded = true
        if PlayLog then PlayLog.log({ type = 'mxms_horoscope_success', card = card }) end
        local stg = card.ability.extra
        SMODS.calculate_effect(
            {
                message = localize('k_mxms_success_ex'),
                colour = G.C.GREEN,
                sound = 'tarot1',
                func = function()
                    Maximus.set_horoscope_success(card)
                    check_for_unlock({ type = "all_horoscopes" })
                    if TheFamily then G.GAME.horoscope_alert = true end
                end
            }, card)
        SMODS.smart_level_up_hand(card, stg.most_played_hand, false, stg.upgrade)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card:start_dissolve({ Maximus.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
        G.GAME.zodiac_killer_pools["Scorpio"] = false
        SMODS.calculate_context({ mxms_beat_horoscope = true })
    end,
    fail = function(self, card)
        SMODS.calculate_effect(
            {
                message = localize('k_mxms_failed_ex'),
                colour = G.C.RED,
                sound = 'tarot2',
                func = function() if TheFamily then G.GAME.horoscope_alert = true end end
            }, card)
    end,
    reset = function(self, card)
        card.ability.extra.hands = 0
    end,
    can_use = function(self, card) return false end
}
