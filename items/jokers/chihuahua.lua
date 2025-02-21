SMODS.Joker {
    key = 'chihuahua',
    loc_txt = {
        name = 'Chihuahua',
        text = { 'Retriggers cards with ranks that appear', 'the least number of times in the deck the', 'same number of times that rank appears', '{C:inactive}Does not activate if there is a tie{}', '{C:inactive}Limit of 10 retriggers{}' }
    },
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
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        if context.before then
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
                    if v.freq < card.ability.extra.least_count or card.ability.extra.least_count == 0 then
                        card.ability.extra.least_id = v.id
                        card.ability.extra.least_count = v.freq
                        card.ability.extra.tie = false
                    elseif v.freq == card.ability.extra.least_count then
                        card.ability.extra.tie = true
                    end
                end
            end
        end

        if context.cardarea == G.play and context.repetition and tostring(context.other_card.base.id) == card.ability.extra.least_id and not card.ability.extra.tie then
            local reps
            if card.ability.extra.least_count <= 10 then
                reps = card.ability.extra.least_count
            else
                reps = 10
            end
            return {
                message = localize('k_again_ex'),
                repetitions = reps,
                card = card
            }
        end

        if context.after then
            card.ability.extra.least_id = '0'
            card.ability.extra.least_count = 0
            card.ability.extra.tie = false
        end
    end
}
