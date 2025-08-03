SMODS.Joker {
    key = 'chekhov',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 10
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main and G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown then
            return {
                Xmult_mod = G.GAME.round_resets.blind_ante,
                message = 'x' .. G.GAME.round_resets.blind_ante,
                colour = G.C.MULT,
                card = card
            }
        end
    end,
    in_pool = function(self, args)
        if G.GAME.round_resets.blind_ante <= 4 then
            return true
        end

        return false
    end
}
