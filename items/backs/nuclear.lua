SMODS.Back {
    key = 'nuclear',
    atlas = 'Modifiers',
    pos = {
        x = 2,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    apply = function(self, back)
        --Change blind scaling
        G.GAME.modifiers.mxms_nuclear_size = true

        --Change scoring calc method
        SMODS.set_scoring_calculation('exponent')

        --Change joker slots
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - 4
    end
}

local cashs = check_and_set_high_score
function check_and_set_high_score(score, amt)
    if G.GAME.modifiers.mxms_nuclear_size then
        if not amt or type(amt) ~= 'number' then return end
        if G.GAME.round_scores[score] and math.floor(amt) > (G.GAME.round_scores[score].amt or 0) then
            G.GAME.round_scores[score].amt = math.floor(amt)
        end
        return
    end
    cashs(score, amt)
end
