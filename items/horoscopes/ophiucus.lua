SMODS.Consumable {
    key = 'ophiucus',
    set = 'Spectral',
    loc_txt = {
        name = 'Ophiucus',
        text = { 'Play every non-secret hand type', 'within the next {C:attention}#2#{} antes to', 'create a {C:dark_edition}Negative {C:spectral}Soul', '{C:inactive}Currently: #1#/9' }
    },
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 2
    },
    config = {
        hands = {
            ["Straight Flush"] = false,
            ["Four of a Kind"] = false,
            ["Full House"] = false,
            ["Flush"] = false,
            ["Straight"] = false,
            ["Three of a Kind"] = false,
            ["Two Pair"] = false,
            ["Pair"] = false,
            ["High Card"] = false,
        },
        extra = {
            antes = 0,
            ante_limit = 2,
            handtypes_played = 0
        }
    },
    hidden = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability
        info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
        return { vars = { stg.extra.handtypes_played, stg.extra.ante_limit } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability
        if context.before and not stg.hands[context.scoring_name] then
            stg.hands[context.scoring_name] = true
            stg.extra.handtypes_played = stg.extra.handtypes_played + 1
            SMODS.calculate_effect({ message = stg.extra.handtypes_played .. "/9", colour = G.C.HOROSCOPE }, card)

            local all_hands = true
            for k, v in pairs(stg.hands) do
                if not v then
                    all_hands = false
                    break
                end
            end
            if all_hands then
                self:succeed(card)
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
            stg.extra.antes = stg.extra.antes + 1
            if stg.extra.antes >= stg.extra.ante_limit then
                self:fail(card)
            else
                SMODS.calculate_effect({ message = stg.extra.ante_limit - stg.extra.antes .. " Ante Left..." , colour = G.C.HOROSCOPE }, card)
            end
        end
    end,
    succeed = function(self, card)
        SMODS.calculate_effect({ message = "Success!", colour = G.C.GREEN, sound = 'tarot1' }, card)
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
        SMODS.calculate_context({ beat_horoscope = true })
        G.E_MANAGER:add_event(Event({
            func = function()
                card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                return true
            end
        }))
    end,
    fail = function(self, card)
        local stg = card.ability
        SMODS.calculate_effect({ message = "Failed!", colour = G.C.RED, sound = 'tarot2' }, card)
        if not next(SMODS.find_card('j_mxms_cheat_day')) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    card:start_dissolve({ G.C.HOROSCOPE }, nil, 1.6)
                    return true
                end
            }))
        else
            stg.hands = {
                ["Straight Flush"] = false,
                ["Four of a Kind"] = false,
                ["Full House"] = false,
                ["Flush"] = false,
                ["Straight"] = false,
                ["Three of a Kind"] = false,
                ["Two Pair"] = false,
                ["Pair"] = false,
                ["High Card"] = false,
            }
        end
        SMODS.calculate_context({ failed_horoscope = true })
    end,
    add_to_deck = function(self, card, from_debuff)
        local stg = card.ability
        stg.hands = {
            ["Straight Flush"] = false,
            ["Four of a Kind"] = false,
            ["Full House"] = false,
            ["Flush"] = false,
            ["Straight"] = false,
            ["Three of a Kind"] = false,
            ["Two Pair"] = false,
            ["Pair"] = false,
            ["High Card"] = false,
        }
    end
}
