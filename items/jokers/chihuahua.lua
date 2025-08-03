SMODS.Joker {
    key = 'chihuahua',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 6
    },
    rarity = 3,
    config = {
        extra = {
            least_id = '0',
            least_count = 0,
            tie = false
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.before and not context.blueprint then
            local ranks = {
                ["2"] = { freq = 0, id = '2' },
                ["3"] = { freq = 0, id = '3' },
                ["4"] = { freq = 0, id = '4' },
                ["5"] = { freq = 0, id = '5' },
                ["6"] = { freq = 0, id = '6' },
                ["7"] = { freq = 0, id = '7' },
                ["8"] = { freq = 0, id = '8' },
                ["9"] = { freq = 0, id = '9' },
                ["10"] = { freq = 0, id = '10' },
                ["11"] = { freq = 0, id = '11' },
                ["12"] = { freq = 0, id = '12' },
                ["13"] = { freq = 0, id = '13' },
                ["14"] = { freq = 0, id = '14' }
            }

            for i = 1, #G.playing_cards do
                if not SMODS.has_no_rank(G.playing_cards[i]) then
                    ranks[tostring(G.playing_cards[i].base.id)].freq = ranks[tostring(G.playing_cards[i].base.id)].freq +
                        1
                end
            end

            for k, v in pairs(ranks) do
                if v.freq ~= 0 then
                    if v.freq < stg.least_count or stg.least_count == 0 then
                        stg.least_id = v.id
                        stg.least_count = v.freq
                        stg.tie = false
                    elseif v.freq == stg.least_count then
                        stg.tie = true
                    end
                end
            end
        end

        if context.cardarea == G.play and context.repetition and tostring(context.other_card.base.id) == stg.least_id and not stg.tie then
            local reps
            if stg.least_count <= 10 then
                reps = stg.least_count
            else
                reps = 10
            end
            return {
                message = localize('k_again_ex'),
                repetitions = reps,
                card = card
            }
        end

        if context.after and not context.blueprint then
            stg.least_id = '0'
            stg.least_count = 0
            stg.tie = false
        end
    end
}
