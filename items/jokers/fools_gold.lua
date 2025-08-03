SMODS.Joker {
    key = 'fools_gold',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 13
    },
    rarity = 1,
    config = {
        extra = {
            money = 1,
            tally = 0
        }
    },
    mxms_credits = {
        art = { "PsyAlola" },
        code = { "theAstra" },
        idea = { "PsyAlola" }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        local gold_cards = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_gold') then
                    gold_cards = gold_cards + 1
                end
            end
        end

        stg.tally = math.floor(gold_cards / 2)

        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return {
            vars = { stg.money, stg.tally * stg.money }
        }
    end,
    calc_dollar_bonus = function(self, card)
        local stg = card.ability.extra
        local gold_cards = 0
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_gold') then
                gold_cards = gold_cards + 1
            end
        end

        stg.tally = math.floor(gold_cards / 2)
        return card.ability.extra.tally * card.ability.extra.money
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_gold') then
                return true
            end
        end

        return false
    end
}
