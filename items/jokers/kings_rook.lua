SMODS.Joker {
    key = 'kings_rook',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 10
    },
    rarity = 1,
    config = {
        extra = {
            base_xmult = 1.5,
            better_xmult = 2,
            both_ranks = false
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = false,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.base_xmult, stg.better_xmult } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before then
            local fives = false
            local kings = false

            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 5 then
                    fives = true
                elseif context.scoring_hand[i]:get_id() == 13 then
                    kings = true
                end
            end

            stg.both_ranks = fives and kings
        end

        if context.individual and context.cardarea == G.play then
            local first_five = nil
            local first_king = nil

            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 5 and not first_five then
                    first_five = context.scoring_hand[i]
                elseif context.scoring_hand[i]:get_id() == 13 and not first_king then
                    first_king = context.scoring_hand[i]
                end
            end

            if context.other_card == first_five or context.other_card == first_king then
                return {
                    x_mult = stg.both_ranks and stg.better_xmult or stg.base_xmult
                }
            end
        end
    end
}
